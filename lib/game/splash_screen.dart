import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rhythm_flux/screens/main_menu_screen.dart';
import 'package:rhythm_flux/screens/signup_screen.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/token_checker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/token_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final _tokenHelper = TokenHelper();
  final UserService _userService = UserService();
  bool isChecking = false;

  Future<void> tokenChecker() async {
   await DecoderUtils.init();
    _tokenHelper.init();
    if (isChecking) return;
    isChecking = true;
    try {
      await _userService.getUser();
      bool isVerified = DecoderUtils.isVerifiedToken();
      final data = _tokenHelper.tokenLocalGetter();
      if (!mounted) return;
      if (data != null &&
          data.isNotEmpty &&
          isVerified &&
          isTokenExpired(data)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainMenuScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                SignupScreen(isTokenValid: isTokenExpired(data ?? '')),
          ),
        );
      }
    } catch (e) {
      print("token error:$e");
    } finally {
      isChecking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    tokenChecker();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      tokenChecker();
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
                      fontWeight: FontWeight.bold,
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



