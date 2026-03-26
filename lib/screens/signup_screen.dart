import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/screens/main_menu_screen.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/mail_pass_controller.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../constant/app_texts.dart';
import '../constant/app_texts_style.dart';

class SignupScreen extends StatefulWidget {
  final bool isTokenValid;

  const SignupScreen({super.key, required this.isTokenValid});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool signUp = false;
  late TokenHelper _tokenHelper;
  bool isVerified = false;
  late final UserService _userService;

  @override
  void initState() {
    _userService = UserService();
    _tokenHelper = TokenHelper();
    getBoolValue();
    print('iss:${isVerified}');
    print("------${isVerified}");
    super.initState();
  }

  Future<void> getBoolValue() async {
    await _userService.getUser();
    final id = await _tokenHelper.tokenLocalGetter();
    print("your ID:$id");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(136, 0, 110, 1),
          title: Text(
            signUp ? AppTexts.signup2 :
            AppTexts.login,
            style: AppTextStyles.loginTextStyle(context),
          ),
        ),
        body: Container(
          padding: EdgeInsetsDirectional.only(start: 12, end: 12, top: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // email field
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  } else if (value.isEmpty || !MailUtils.isEmail(value)) {
                    return "Enter Valid Mail Format";
                  }
                  return null;
                },
                controller: _emailController,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 10.0, // shadow blur
                      color: Colors.lightBlueAccent, // shadow color
                      offset: Offset(2.0, 2.0), // how much shadow will be shown
                    ),
                  ],
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "example@mail.com",
                  prefixIcon: Icon(Icons.email_outlined),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              //password field
              SizedBox(height: 12),
              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty && !MailUtils.isStrongPassword(value)) {
                    return "Password must include:\n"
                        "• At least 8 characters\n"
                        "• One uppercase letter\n"
                        "• One lowercase letter\n"
                        "• One number";
                  } else if (value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                controller: _passController,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 10.0, // shadow blur
                      color: Colors.purpleAccent, // shadow colorScheme
                      offset: Offset(2.0, 2.0), // how much shadow will be shown
                    ),
                  ],
                ),
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: "ex:Tr0ub4dor&3sda",
                  prefixIcon: Icon(Icons.lock_outline),
                  isDense: true,

                  filled: true,
                  fillColor: Colors.white,

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  // _userService.login(
                  //   email: _emailController.text,
                  //   password: _passController.text,
                  // );

                  if (_formKey.currentState!.validate()) {
                    isVerified = await DecoderUtils.isVerifiedToken();
                    if (isVerified && widget.isTokenValid) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MainMenuScreen(),
                        ),
                      );
                    } else {
                      signUp
                          ? _userService.createAccount(
                        email: _emailController.text,
                        password: _passController.text,
                      )

                          : _userService.login(
                        email: _emailController.text,
                        password: _passController.text,
                      );
                      if (isVerified) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MainMenuScreen(),
                          ),
                        );
                      }
                      else {
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.6),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.purpleAccent,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Please wait...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                        // ScaffoldMessenger
                        //     .of(context)
                        //     .showSnackBar(
                        //   SnackBar(
                        //     content: Text("Please verify your email",
                        //       style: TextStyle(color: Colors.purple),),
                        //     backgroundColor: Colors.black,
                        //   ),
                        // );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) =>
                        //     const SignupScreen(isTokenValid: false),
                        //   ),
                        // );
                      }
                      // await _userService.getUser();
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromRGBO(136, 0, 110, 1),
                  ),
                  fixedSize: WidgetStateProperty.all(Size(500, 50)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Text(
                  signUp ? AppTexts.signup : AppTexts.login,
                  style: GoogleFonts.rubikPixels(
                    fontSize: 20,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    signUp = !signUp;
                  });
                },
                child: Text(
                  signUp
                      ? "Already Have Account Login..."
                      : "Don't have account? Create... :)",
                  style: TextStyle(
                    color: Color.fromRGBO(136, 0, 110, 1),
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(32, 60, 20, 0.8),
                        offset: Offset(2, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


