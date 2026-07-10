import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/screens/cart/controller/cart_controller.dart';
import 'package:flutter_technical_task/screens/product/controller/product_controller.dart';
import 'package:flutter_technical_task/utils/ui/app_cached_image.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: CommonViews().customText(
            textContent: 'Favorites',
            fontSize: AppSize.titleText,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: Consumer<ProductController>(
          builder: (context, controller, child) {
            final favorites = controller.favoriteProducts;

            if (favorites.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          size: 12.w,
                          color: AppColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      CommonViews().customText(
                        textContent: 'No favorites yet',
                        fontSize: AppSize.titleText,
                        fontWeight: FontWeight.w700,
                        textColor: AppColors.textPrimary,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 1.h),

                      CommonViews().customText(
                        textContent:
                        'Products you mark as favorites will appear here for quick access.',
                        fontSize: AppSize.bodyText,
                        textColor: AppColors.textSecondary,
                        textAlign: TextAlign.center,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(AppSize.pagePadding),
              itemCount: favorites.length,
              separatorBuilder: (_, _) =>
                  SizedBox(height: AppSize.smallSpacing),
              itemBuilder: (context, index) {
                final product = favorites[index];

                return Consumer<CartController>(
                  builder: (context, cartController, child) {
                    final bool isInCart =
                    cartController.isProductInCart(product.id);

                    return Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(
                          AppSize.productCardRadius,
                        ),
                        border: Border.all(
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppCachedImage(
                                imageUrl: product.image,
                                width: 22.w,
                                height: 22.w,
                                fit: BoxFit.contain,
                                radius: 10,
                              ),

                              SizedBox(width: 3.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonViews().customText(
                                      textContent: product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: AppSize.bodyText,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    SizedBox(height: 0.8.h),

                                    CommonViews().customText(
                                      textContent:
                                      '\$${product.price.toStringAsFixed(2)}',
                                      fontSize: AppSize.bodyText,
                                      fontWeight: FontWeight.w700,
                                      textColor: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  controller.toggleFavorite(product.id);
                                },
                                icon: Icon(
                                  Icons.favorite_rounded,
                                  color: AppColors.favoriteColor,
                                  size: 22.sp,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: AppSize.mediumSpacing),

                          CommonViews().customButton(
                            height: 5.5.h,
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
                                      backgroundColor:
                                      AppColors.primaryColor,
                                    ),
                                  );
                              } catch (error) {
                                debugPrint(
                                  'Add to cart error: $error',
                                );

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
                                      backgroundColor:
                                      AppColors.errorColor,
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
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}