import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_assets.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/utils/ui/custom_slider_with_dots.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: AppSize.homeTopSpacing,),
            CarouselSliderImage(
                images: [
                  firstHomeSlide,
                  secondHomeSlide,
                  thirdHomeSlide,
                ]
            ),
          ],
        ),
      ),
    );
  }
}
