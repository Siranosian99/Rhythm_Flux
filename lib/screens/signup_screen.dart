import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/features/auth/auth_cubit.dart';
import 'package:rhythm_flux/features/user/user_cubit.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/screens/main_menu_screen.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/mail_pass_controller.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../core/constant/app_texts.dart';
import '../core/constant/app_texts_style.dart';
import '../widgets/select_bpm_snackBar.dart';

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
  bool isChecking = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // init();
    DecoderUtils.init();
    // _userService = UserService();
    _tokenHelper = TokenHelper();

    getBoolValue();
    super.initState();
  }

  Future<void> getBoolValue() async {
    await context.read<UserCubit>().getUser();
    // final id = _tokenHelper.tokenLocalGetter();
  }

  void clearTextFields() {
    _passController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(136, 0, 110, 1),
          title: Text(
            signUp ? AppTexts.signup2 : AppTexts.login,
            style: AppTextStyles.loginTextStyle(context),
          ),
        ),
        body: isChecking
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withValues(alpha: 0.6),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.blueAccent,
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
              )
            : Container(
                padding: EdgeInsetsDirectional.only(
                  start: 12,
                  end: 12,
                  top: 40,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
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
                      style: const TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 8.0,
                            color: Colors.lightBlueAccent,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "example@mail.com",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.lightBlueAccent,
                          size: 21,
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 48,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    //password field
                    SizedBox(height: 12),
                    TextFormField(
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            !MailUtils.isStrongPassword(value)) {
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

                      style: const TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 8.0,
                            color: Colors.purpleAccent,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: "ex:Tr0ub4dor&3sda",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.purpleAccent,
                          size: 21,
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 48,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          tooltip: obscurePassword
                              ? 'Show password'
                              : 'Hide password',
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey.shade600,
                            size: 21,
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isChecking = true;
                          });
                          try {
                            isVerified = DecoderUtils.isVerifiedToken();
                            if (isVerified && widget.isTokenValid) {
                              if (!context.mounted) return;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MainMenuScreen(),
                                ),
                              );
                            } else {
                              signUp
                                  ? await context
                                        .read<AuthCubit>()
                                        .createAccount(
                                          email: _emailController.text,
                                          password: _passController.text,
                                        )
                                  : await context.read<AuthCubit>().login(
                                      email: _emailController.text,
                                      password: _passController.text,
                                    );

                              isVerified = DecoderUtils.isVerifiedToken();
                              if (isVerified) {
                                if (!context.mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const MainMenuScreen(),
                                  ),
                                );
                              } else {
                                if (!context.mounted) return;

                                showBpmSnackBar(
                                  Icons.error,
                                  context,
                                  AppTexts.verifyEmail1,
                                  AppTexts.verifyEmail2,
                                );
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error:$e"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                isChecking = false;
                              });
                            }
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
                        clearTextFields();
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
