import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CommonViews {
  static final CommonViews _shared = CommonViews._private();

  factory CommonViews() => _shared;

  CommonViews._private();

  TextStyle _textStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? AppColors.textPrimary,
      fontSize: fontSize ?? 15.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: height,
      decoration: decoration,
    );
  }

  Widget customText({
    Key? key,
    required String textContent,
    Color? textColor,
    double? fontSize,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? height,
    TextDecoration? decoration,
  }) {
    return Text(
      textContent,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: true,
      style: _textStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        decoration: decoration,
      ),
    );
  }

  Widget customClickableText({
    required String textContent,
    required VoidCallback onTap,
    Color? textColor,
    double? fontSize,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    TextDecoration? decoration,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.sp),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.4.h),
        child: Text(
          textContent,
          textAlign: textAlign,
          style: _textStyle(
            color: textColor ?? AppColors.primaryColor,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.w500,
            decoration: decoration,
          ),
        ),
      ),
    );
  }

  Widget customButton({
    required Widget child,
    required VoidCallback? onTap,
    Color? backgroundColor,
    Color? disabledColor,
    double? width,
    double? height,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 6.5.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          disabledBackgroundColor: disabledColor ?? AppColors.borderColor,
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.sp),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.whiteColor,
                ),
              )
            : child,
      ),
    );
  }

  Widget customTextField({
    TextEditingController? controller,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 6.5.h,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        style: _textStyle(
          fontSize: 13.sp,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: _textStyle(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.surfaceColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 1.6.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
