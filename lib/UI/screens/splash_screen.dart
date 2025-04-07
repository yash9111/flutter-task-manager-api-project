import 'dart:async';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => LogInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: Positioned(
            top: 40.h,
            bottom: 40.h,
            right: 30.w,
            left: 30.w,
            child: SvgPicture.asset('assets/images/logo.svg',)),
      )
    );
  }
}
