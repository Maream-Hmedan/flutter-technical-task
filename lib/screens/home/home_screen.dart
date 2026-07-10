import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_assets.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/screens/home/widgets/home_carousel_slider.dart';
import 'package:flutter_technical_task/screens/home/widgets/home_search_field.dart';
import 'package:flutter_technical_task/screens/product/controller/product_controller.dart';
import 'package:flutter_technical_task/screens/product/model/product_response.dart';
import 'package:flutter_technical_task/screens/product_details/product_details_screen.dart';
import 'package:flutter_technical_task/utils/helpers/app_navigation.dart';
import 'package:flutter_technical_task/utils/ui/app_cached_image.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProductController>(
          builder: (context, controller, child) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: controller.refreshProducts,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: AppSize.homeTopSpacing),

                      const HomeCarouselSlider(
                        images: [
                          firstHomeSlide,
                          secondHomeSlide,
                          thirdHomeSlide,
                        ],
                      ),

                      SizedBox(height: AppSize.mediumSpacing),
                      HomeSearchField(),

                      _buildProductsSection(controller),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductsSection(ProductController controller) {
    switch (controller.apiStatus) {
      case ApiStatus.loading:
        return _buildProductsShimmer();

      case ApiStatus.empty:
        return _buildStatusState(
          icon: Icons.inventory_2_outlined,
          title: 'No products found',
          description:
              'There are no products available right now. Please check again later.',
        );

      case ApiStatus.error:
        return _buildStatusState(
          icon: Icons.wifi_off_rounded,
          iconColor: AppColors.errorColor,
          title: 'Unable to load products',
          description: controller.errorMessage.isNotEmpty
              ? controller.errorMessage
              : 'Something went wrong while loading products. Please try again.',
          buttonText: 'Try Again',
          onButtonTap: controller.getProducts,
        );

      case ApiStatus.success:
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.pagePadding,
            vertical: AppSize.smallSpacing,
          ),
          itemCount: controller.filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final ProductResponse product = controller.filteredProducts[index];

            return _buildProductCard(
              product: product,
              isFavorite: controller.isFavorite(product.id),
              onCardTap: () {
                AppNavigator.of(context).push(
                  ProductDetailsScreen(product: product),
                );
              },
              onFavoriteTap: () {
                controller.toggleFavorite(product.id);
              },
              onAddToCart: () {},
            );
          },
        );
    }
  }

  Widget _buildProductsShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.pagePadding,
        vertical: AppSize.smallSpacing,
      ),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.borderColor,
          highlightColor: AppColors.surfaceColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppSize.productCardRadius),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusState({
    required IconData icon,
    required String title,
    required String description,
    Color? iconColor,
    String? buttonText,
    VoidCallback? onButtonTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.pagePadding,
        vertical: AppSize.largeSpacing,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppSize.productCardRadius),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: (iconColor ?? AppColors.primaryColor).withValues(
                    alpha: 0.20,
                  ),
                ),
              ),
              child: Icon(
                icon,
                size: 9.w,
                color: iconColor ?? AppColors.primaryColor,
              ),
            ),
            SizedBox(height: AppSize.mediumSpacing),
            CommonViews().customText(
              textContent: title,
              textAlign: TextAlign.center,
              fontSize: AppSize.titleText,
              fontWeight: FontWeight.w700,
              textColor: AppColors.textPrimary,
            ),
            SizedBox(height: AppSize.smallSpacing),
            CommonViews().customText(
              textContent: description,
              textAlign: TextAlign.center,
              fontSize: AppSize.mediumText,
              textColor: AppColors.textSecondary,
              height: 1.5,
            ),
            if (buttonText != null && onButtonTap != null) ...[
              SizedBox(height: AppSize.mediumSpacing),
              CommonViews().customButton(
                width: 45.w,
                height: AppSize.buttonHeight,
                borderRadius: 12,
                onTap: onButtonTap,
                child: CommonViews().customText(
                  textContent: buttonText,
                  fontSize: AppSize.mediumText,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.whiteColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required ProductResponse product,
    required bool isFavorite,
    required VoidCallback onCardTap,
    required VoidCallback onFavoriteTap,
    required VoidCallback onAddToCart,
  }) {
    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(
        AppSize.productCardRadius,
      ),
      child: Container(
        padding: EdgeInsets.all(2.5.w),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCachedImage(
                imageUrl: product.image,
                width: double.infinity,
                fit: BoxFit.contain,
                radius: 10,
              ),
            ),
            SizedBox(height: AppSize.smallSpacing),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonViews().customText(
                    textContent: product.title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppSize.bodyText,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 1.w),
                InkWell(
                  borderRadius: BorderRadius.circular(20.sp),
                  onTap: onFavoriteTap,
                  child: Padding(
                    padding: EdgeInsets.all(0.5.h),
                    child: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite
                          ? AppColors.favoriteColor
                          : AppColors.textSecondary,
                      size: 19.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.7.h),
            CommonViews().customText(
              textContent: '\$${product.price.toStringAsFixed(2)}',
              fontSize: AppSize.bodyText,
              fontWeight: FontWeight.w700,
              textColor: AppColors.primaryColor,
            ),
            SizedBox(height: AppSize.smallSpacing),
            CommonViews().customButton(
              height: 5.h,
              borderRadius: 10,
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 0.8.h,
              ),
              onTap: onAddToCart,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 17.sp,
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: 1.5.w),
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
      ),
    );
  }
}
