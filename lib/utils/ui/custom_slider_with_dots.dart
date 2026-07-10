import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderImage extends StatefulWidget {
  const CarouselSliderImage({
    super.key,
    required this.images,
    this.height,
    this.autoPlay = true,
    this.viewportFraction = 0.88,
    this.borderRadius = 16,
  });

  final List<String> images;
  final double? height;
  final bool autoPlay;
  final double viewportFraction;
  final double borderRadius;

  @override
  State<CarouselSliderImage> createState() => _CarouselSliderImageState();
}

class _CarouselSliderImageState extends State<CarouselSliderImage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.sliderHorizontalPadding,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius,
                ),
                child: Image.asset(
                  widget.images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height ?? AppSize.promotionalSliderHeight,
            autoPlay: widget.autoPlay,
            viewportFraction: widget.viewportFraction,
            enlargeCenterPage: true,
            enlargeFactor: 0.17,
            enableInfiniteScroll: widget.images.length > 1,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration:
            const Duration(milliseconds: 700),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: AppSize.sliderDotsSpacing),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: widget.images.length,
          effect: ExpandingDotsEffect(
            expansionFactor: 3,
            spacing: 8,
            dotHeight: AppSize.sliderDotSize,
            dotWidth: AppSize.sliderDotSize,
            activeDotColor: AppColors.primaryColor,
            dotColor: AppColors.borderColor,
          ),
        ),
      ],
    );
  }
}