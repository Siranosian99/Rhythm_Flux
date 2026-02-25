import 'package:flutter/material.dart';
import 'package:rhythm_flux/constants/app_texts_style.dart';

import '../constants/app_texts.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text(AppTexts.appName,style:AppTextStyles.appNameStyle ?? TextStyle());
        ],
      )));
  }
}
