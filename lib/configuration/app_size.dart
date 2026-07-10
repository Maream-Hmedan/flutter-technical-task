import 'package:sizer/sizer.dart';

class AppSize {
  AppSize._();
  // General
  static double get pagePadding => 5.w;
  static double get smallSpacing => 1.h;
  static double get mediumSpacing => 2.h;
  static double get largeSpacing => 3.h;
  // Splash
  static double get splashLottieWidth => 60.w;
  static double get splashLottieHeight => 60.w;
  static double get splashTitleSize => 22.sp;
  static double get splashSubTitleSize => 11.sp;
  static double get spaceAfterLottie => 2.h;
  static double get spaceBetweenTitleAndSubtitle => 0.5.h;

  // Home
  static double get homeTopSpacing => 1.5.h;
  static double get sliderHorizontalPadding => 1.w;
  static double get promotionalSliderHeight => 20.h;
  static double get promotionalSliderRadius => 16.sp;
  static double get promotionalSliderViewport => 0.88;

  static double get sliderDotsSpacing => 1.5.h;
  static double get sliderDotSize => 0.8.h;

  // Text
  static double get smallText => 10.sp;
  static double get bodyText => 12.sp;
  static double get mediumText => 14.sp;
  static double get titleText => 17.sp;
  static double get largeTitleText => 21.sp;

  // Buttons
  static double get buttonHeight => 6.5.h;
  static double get buttonRadius => 12.sp;

  // Product card
  static double get productImageHeight => 18.h;
  static double get productCardRadius => 14.sp;

  // Bottom navigation
  static double get bottomNavRadius => 18.sp;
  static double get bottomNavIconSize => 20.sp;

  // Indicators
  static double get indicatorSize => 0.8.h;
  static double get activeIndicatorWidth => 6.w;
}