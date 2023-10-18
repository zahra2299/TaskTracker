import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../layout/home_layout.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 3), navigateToHomeScreen);
  }

  void navigateToHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeLayout.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintGreen,
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/splash.png"))),
      ),
    );
  }
}
