import 'package:flutter/material.dart';

import '../constants/app_texts.dart';
import '../constants/app_texts_style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscurePassword = true;

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
        children: [
          // email field
          TextFormField(
      style:TextStyle (
      shadows: [
        Shadow(
        blurRadius:10.0,  // shadow blur
        color: Colors.orange, // shadow color
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
                    color: Colors.l, // shadow color
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
          ElevatedButton(onPressed: () {}, child: Text(AppTexts.login)),
        ],
      ),
    );
  }
}
