import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_assets.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/screens/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:flutter_technical_task/utils/helpers/app_navigation.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:lottie/lottie.dart';

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
                width: AppSize.splashLottieWidth,
                height: AppSize.splashLottieHeight,
                fit: BoxFit.contain,
              ),

              SizedBox(height: AppSize.spaceAfterLottie),

              CommonViews().customText(
                textContent: 'Shoply',
                fontSize: AppSize.splashTitleSize,
                fontWeight: FontWeight.w700,
                textColor: AppColors.primaryColor,
              ),

              SizedBox(height: AppSize.spaceBetweenTitleAndSubtitle),

              CommonViews().customText(
                textContent: 'Smart Shopping Experience',
                fontSize: AppSize.splashSubTitleSize,
                textColor: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
