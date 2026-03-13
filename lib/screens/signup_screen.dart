import 'package:flutter/material.dart';
import 'package:rhythm_flux/service/user_service/users.dart';

import '../constants/app_texts.dart';
import '../constants/app_texts_style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController= TextEditingController();
  final _passController= TextEditingController();

  bool obscurePassword = true;
  final UserService _userService=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.login,
          style: AppTextStyles.loginTextStyle(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // email field
          TextFormField(
      style:TextStyle (
      shadows: [
        Shadow(
        blurRadius:10.0,  // shadow blur
        color: Colors.lightBlueAccent, // shadow color
        offset: Offset(2.0,2.0), // how much shadow will be shown
      )]),
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
            style:TextStyle (
                shadows: [
                  Shadow(
                    blurRadius:10.0,  // shadow blur
                    color: Colors.purpleAccent, // shadow colorScheme
                    offset: Offset(2.0,2.0), // how much shadow will be shown
                  )]),
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
          ElevatedButton(onPressed: () {
             _userService.createAccount(email: _emailController.text, password: _passController.text);

          }, child: Text(AppTexts.login),style:ButtonStyle(
            fixedSize: WidgetStateProperty.all(Size(500, 2))

          ),),
        ],
      ),
    );
  }
}
