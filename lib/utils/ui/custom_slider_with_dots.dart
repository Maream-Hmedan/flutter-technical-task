import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarouselSliderImage extends StatelessWidget {
  const CarouselSliderImage({
    super.key,
    required this.images,
    this.height,
    this.autoPlay = true,
    this.viewportFraction = 0.9,
    this.borderRadius = 16,
  });

  final List<String> images;
  final double? height;
  final bool autoPlay;
  final double viewportFraction;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius.sp),
          child: Image.asset(
            images[index],
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        height: height ?? 25.h,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        viewportFraction: viewportFraction,
        enableInfiniteScroll: images.length > 1,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 700),
      ),
    );
  }
}