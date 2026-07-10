import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_assets.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:flutter_technical_task/utils/helpers/app_navigation.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      AppNavigator.of(context).pushAndRemoveUntil(
        const BottomNavBarScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                splashLottie,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 2.h),

              CommonViews().customText(
                textContent: 'Shoply',
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                textColor: AppColors.primaryColor,
              ),

              SizedBox(height: 0.5.h),

              CommonViews().customText(
                textContent: 'Smart Shopping Experience',
                fontSize: 11.sp,
                textColor: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
