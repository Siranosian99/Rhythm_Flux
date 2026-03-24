import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rhythm_flux/screens/main_menu_screen.dart';
import 'package:rhythm_flux/screens/signup_screen.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/token_checker.dart';

import '../utils/token_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _tokenHelper = TokenHelper();
  late final UserService _userService;
  late bool isVerified;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      tokenChecker();
    });
  }

  Future<void> tokenChecker() async {
    _userService = UserService();
    await _userService.getUser();
    // isVerified = (await DecoderUtils.isVerifiedToken())!;
    final data = await _tokenHelper.tokenLocalGetter();
    setState(() {
      if (data != null && data.isNotEmpty) {
        isTokenExpired(data);
      }
    });
    // && isVerified
    if (!mounted) return;
    if (!isTokenExpired(data ?? "") ) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MainMenuScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignupScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/Astro.png', fit: BoxFit.cover),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please Wait...",
                  style: GoogleFonts.comicNeue(
                    textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold, // 👈 bold
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const LinearProgressIndicator(
                  backgroundColor: Colors.purpleAccent,
                  color: Colors.white,
                  minHeight: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
