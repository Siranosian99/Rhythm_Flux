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
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  late bool isVerified;
  late DecoderUtils _decoderUtils;

  // late bool isVerified;
  final UserService _userService = UserService();

  @override
  void initState() {
    _decoderUtils = DecoderUtils();
    getBoolValue();
    super.initState();
  }

  Future<void> getBoolValue() async {
    isVerified = await DecoderUtils.isVerifiedToken() ?? false;
    final id = await TokenHelper().userIdLocalGetter();
    print("your IDDD:$id");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(136, 0, 110, 1),
          title: Text(
            AppTexts.login,
            style: AppTextStyles.loginTextStyle(context),
          ),
        ),
        body: Container(
          padding: EdgeInsetsDirectional.only(start: 12, end: 12, top: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue, // üst kısım
                Colors.purple, // alt kısım
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
                    return "Enter Valid Mail";
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
                      _userService.login(
                        email: _emailController.text,
                        password: _passController.text,
                      );
                  // await UserService().getUser();
                  //     _userService.login(
                  //       email: _emailController.text,
                  //       password: _passController.text,
                  //     );
                  //   }
                  // if (_formKey.currentState!.validate()) {
                  //   if (isVerified) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => const MainMenuScreen(),
                  //       ),
                  //     );
                  //   } else {
                  //     _userService.login(
                  //       email: _emailController.text,
                  //       password: _passController.text,
                  //     );
                  //   }
                  //
                  // }
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
                  AppTexts.login,
                  style: GoogleFonts.pixelifySans(
                    fontSize: 20,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
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
