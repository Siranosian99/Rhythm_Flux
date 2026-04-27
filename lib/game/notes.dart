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
    _userService = UserService();
    await _userService.getUser();
    isVerified = await DecoderUtils.isVerifiedToken();
    final data = await _tokenHelper.tokenLocalGetter();

    if (data != null && data.isNotEmpty && isVerified) {
      isTokenExpired(data);
    }

    if (!mounted) return;
    if (data != null && data.isNotEmpty && isVerified) {
      if (!isTokenExpired(data)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainMenuScreen()),
        );
      }
    } else if (data == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              SignupScreen(isTokenValid: isTokenExpired(data ?? '')),
        ),
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





// if (e.response?.statusCode == 401) {
//
//   final token = await _tokenHelper.tokenLocalGetter();
//
//   if (token == null || token.isEmpty) {
//     await _tokenHelper.refreshTokenLocalRemover();
//     await _tokenHelper.tokenLocalRemover();
//     return handler.next(e);
//   }
//
//   final isExpired = isTokenExpired(token);
//
//   if (isExpired) {
//
//     final success = await refreshToken();
//
//     if (!success) {
//       await _tokenHelper.refreshTokenLocalRemover();
//       await _tokenHelper.tokenLocalRemover();
//       return handler.next(e);
//     }
//
//     final newToken = await _tokenHelper.tokenLocalGetter();
//
//     if (newToken == null || newToken.isEmpty) {
//       await _tokenHelper.refreshTokenLocalRemover();
//       await _tokenHelper.tokenLocalRemover();
//       return handler.next(e);
//     }
//
//     e.requestOptions.headers["Authorization"] = "Bearer $newToken";
//
//     final retryResponse = await _dio.fetch(e.requestOptions);
//     return handler.resolve(retryResponse);
//   }
//
//   // token expired değil ama 401 → invalid token
//   await _tokenHelper.refreshTokenLocalRemover();
//   await _tokenHelper.tokenLocalRemover();
// }
//
// return handler.next(e);

//import 'package:flutter/material.dart';
// import 'package:rhythm_flux/screens/main_menu_screen.dart';
// import 'package:rhythm_flux/screens/signup_screen.dart';
// import 'package:rhythm_flux/service/user_service/users.dart';
// import 'package:rhythm_flux/utils/decode_token_details.dart';
// import '../utils/token_checker.dart';
// import '../utils/token_helper.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with WidgetsBindingObserver {
//   final _tokenHelper = TokenHelper();
//   late final UserService _userService;
//
//   bool _isChecking = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _userService = UserService();
//     WidgetsBinding.instance.addObserver(this);
//
//     Future.microtask(() => tokenChecker());
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       tokenChecker();
//     }
//   }
//
//   Future<void> tokenChecker() async {
//     if (_isChecking) return;
//     _isChecking = true;
//
//     try {
//       print("TOKEN CHECK START");
//
//       final token = await _tokenHelper.tokenLocalGetter();
//       final isVerified = await DecoderUtils.isVerifiedToken();
//
//       print("TOKEN: $token");
//       print("IS VERIFIED: $isVerified");
//
//       // ❌ TOKEN YOK
//       if (token == null || token.isEmpty) {
//         print("NO TOKEN → SIGNUP");
//
//         if (!mounted) return;
//         _go(SignupScreen(isTokenValid: false));
//         return;
//       }
//
//       // ✔ TOKEN VALID
//       if (!isTokenExpired(token) && isVerified) {
//         print("TOKEN VALID → MAIN");
//
//         if (!mounted) return;
//         _go(const MainMenuScreen());
//         return;
//       }
//
//       // 🔥 TOKEN EXPIRED → REFRESH
//       if (isTokenExpired(token)) {
//         print("TOKEN EXPIRED → REFRESH");
//
//         // ❗ BURASI FIX: void olma ihtimaline karşı return kullanmıyoruz
//         await _userService.getUser();
//
//         final newToken = await _tokenHelper.tokenLocalGetter();
//
//         if (newToken == null || newToken.isEmpty) {
//           print("REFRESH FAILED → SIGNUP");
//
//           if (!mounted) return;
//           _go(SignupScreen(isTokenValid: false));
//           return;
//         }
//
//         print("REFRESH SUCCESS → MAIN");
//
//         if (!mounted) return;
//         _go(const MainMenuScreen());
//         return;
//       }
//
//       print("FALLBACK → SIGNUP");
//
//       if (!mounted) return;
//       _go(SignupScreen(isTokenValid: false));
//
//     } catch (e) {
//       print("TOKEN CHECK ERROR: $e");
//
//       if (!mounted) return;
//       _go(SignupScreen(isTokenValid: false));
//     } finally {
//       _isChecking = false;
//     }
//   }
//
//   void _go(Widget page) {
//     if (!mounted) return;
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => page),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset('assets/images/Astro.png', fit: BoxFit.cover),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Please Wait...",
//                   style: GoogleFonts.comicNeue(
//                     textStyle: const TextStyle(
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const LinearProgressIndicator(
//                   backgroundColor: Colors.purpleAccent,
//                   color: Colors.white,
//                   minHeight: 12,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





// onError: (DioException e, handler) async {
// if (e.response?.statusCode == 401) {
// final token = await _tokenHelper.tokenLocalGetter();
//
// if (token == null || token.isEmpty) {
// await _tokenHelper.refreshTokenLocalRemover();
// print("------------- pre 1 latest removers");
// return handler.next(e);
// }
// print("q3e${isTokenExpired(token)}");
// final isExpired = isTokenExpired(token);
// if (isExpired) {
// print("ENTERED EXPIRED BLOCK");
//
// try {
// final success = await refreshToken()
//     .timeout(const Duration(seconds:4));
//
// print("REFRESH RESULT: $success");
//
// if (!success) {
// print("REFRESH FAILED");
// return;
// }
//
// final newToken = await _tokenHelper.tokenLocalGetter();
// print("NEW TOKEN: $newToken");
//
// } catch (e) {
// print("REFRESH ERROR: $e");
// }
// }
//
// // token expired değil ama 401 → invalid token
// await _tokenHelper.refreshTokenLocalRemover();
// await _tokenHelper.tokenLocalRemover();
// print("------------- latest removers");
// }
//
// return handler.next(e);
// },