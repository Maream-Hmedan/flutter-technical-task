import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
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
                child: CommonViews().customText(
                  textContent: 'No favorite products yet',
                  textColor: AppColors.textSecondary,
                  fontSize: AppSize.bodyText,
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
                        onTap: () {
                          // Add to Cart
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.whiteColor,
                              size: 19.sp,
                            ),
                            SizedBox(width: 2.w),
                            CommonViews().customText(
                              textContent: 'Add to Cart',
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
        ),
      ),
    );
  }
}