import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:sizer/sizer.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius = 12,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.sp),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,

        placeholder: (_, _) {
          return Container(
            width: width,
            height: height,
            color: AppColors.borderColor.withAlpha(38),
            alignment: Alignment.center,
            child: SizedBox(
              width: 6.w,
              height: 6.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryColor,
              ),
            ),
          );
        },

        errorWidget: (_, _, _) {
          return Container(
            width: width,
            height: height,
            color: AppColors.borderColor.withAlpha(38),
            alignment: Alignment.center,
            child: Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.textSecondary,
              size: 8.w,
            ),
          );
        },
      ),
    );
  }
}