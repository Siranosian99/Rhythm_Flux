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
  late final UserService _userService;
  late bool isVerified;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration(seconds: 2), () {
      tokenChecker();
    });
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

  Future<void> tokenChecker() async {
    try {
      _userService = UserService();

      var token = await _tokenHelper.tokenLocalGetter();

      print("TOKEN (ilk): $token");

      // TOKEN YOK
      if (token == null || token.isEmpty) {
        if (!mounted) return;
        _go(SignupScreen(isTokenValid: false));
        return;
      }

      // TOKEN EXPIRED → REFRESH
      if (isTokenExpired(token)) {
        print("TOKEN EXPIRED → REFRESH");

        await _userService.getUser();

        // 🔥 EN ÖNEMLİ SATIR
        token = await _tokenHelper.tokenLocalGetter();

        print("TOKEN (refresh sonrası): $token");

        if (token == null || token.isEmpty) {
          if (!mounted) return;
          _go(SignupScreen(isTokenValid: false));
          return;
        }
      }

      final isVerified = await DecoderUtils.isVerifiedToken();

      print("VERIFIED: $isVerified");

      // TOKEN GEÇERLİ
      if (!isTokenExpired(token) && isVerified) {
        if (!mounted) return;
        _go(const MainMenuScreen());
        return;
      }

      // fallback
      if (!mounted) return;
      _go(SignupScreen(isTokenValid: false));

    } catch (e) {
      print("TOKEN CHECK ERROR: $e");

      if (!mounted) return;
      _go(SignupScreen(isTokenValid: false));
    }
  }

  void _go(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
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
