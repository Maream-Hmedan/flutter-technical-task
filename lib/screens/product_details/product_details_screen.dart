import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/screens/cart/controller/cart_controller.dart';
import 'package:flutter_technical_task/screens/product/model/product_response.dart';
import 'package:flutter_technical_task/utils/ui/app_cached_image.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final ProductResponse product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonViews().customText(
          textContent: 'Product Details',
          fontSize: AppSize.titleText,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.pagePadding,
            vertical: AppSize.mediumSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 40.h,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(
                    AppSize.productCardRadius,
                  ),
                  border: Border.all(
                    color: AppColors.borderColor,
                  ),
                ),
                child: AppCachedImage(
                  imageUrl: product.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  radius: 12,
                ),
              ),

              SizedBox(height: AppSize.mediumSpacing),

              CommonViews().customText(
                textContent: product.title,
                fontSize: AppSize.titleText,
                fontWeight: FontWeight.w700,
                textColor: AppColors.textPrimary,
              ),

              SizedBox(height: AppSize.smallSpacing),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: CommonViews().customText(
                      textContent: product.category,
                      fontSize: AppSize.bodyText,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.primaryColor,
                    ),
                  ),

                  const Spacer(),

                  Icon(
                    Icons.star_rounded,
                    color: AppColors.ratingColor,
                    size: 20.sp,
                  ),

                  SizedBox(width: 1.w),

                  CommonViews().customText(
                    textContent:
                    '${product.rating.rate.toStringAsFixed(1)} '
                        '(${product.rating.count})',
                    fontSize: AppSize.bodyText,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),

              SizedBox(height: AppSize.mediumSpacing),

              CommonViews().customText(
                textContent: '\$${product.price.toStringAsFixed(2)}',
                fontSize: AppSize.largeTitleText,
                fontWeight: FontWeight.w700,
                textColor: AppColors.primaryColor,
              ),

              SizedBox(height: AppSize.mediumSpacing),

              CommonViews().customText(
                textContent: 'Description',
                fontSize: AppSize.titleText,
                fontWeight: FontWeight.w700,
              ),

              SizedBox(height: AppSize.smallSpacing),

              CommonViews().customText(
                textContent: product.description,
                fontSize: AppSize.bodyText,
                textColor: AppColors.textSecondary,
                height: 1.6,
              ),

              SizedBox(height: AppSize.largeSpacing),

              Consumer<CartController>(
                builder: (context, cartController, child) {
                  final bool isInCart =
                  cartController.isProductInCart(product.id);

                  return CommonViews().customButton(
                    height: AppSize.buttonHeight,
                    borderRadius: 12,
                    onTap: isInCart
                        ? () {}
                        : () async {
                      try {
                        await cartController.addProduct(product);

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Product added to cart',
                                    ),
                                  ),
                                ],
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              margin: EdgeInsets.all(16),
                              duration: Duration(seconds: 2),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          );
                      } catch (error) {
                        debugPrint('Add to cart error: $error');

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Unable to add product to cart',
                                    ),
                                  ),
                                ],
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              margin: EdgeInsets.all(16),
                              duration: Duration(seconds: 2),
                              backgroundColor: AppColors.errorColor,
                            ),
                          );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isInCart
                              ? Icons.check_circle_outline
                              : Icons.shopping_cart_outlined,
                          color: AppColors.whiteColor,
                          size: 19.sp,
                        ),
                        SizedBox(width: 2.w),
                        CommonViews().customText(
                          textContent: isInCart
                              ? 'Added'
                              : 'Add to Cart',
                          fontSize: AppSize.mediumText,
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}