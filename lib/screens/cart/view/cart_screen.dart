import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/screens/cart/controller/cart_controller.dart';
import 'package:flutter_technical_task/utils/ui/app_cached_image.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: CommonViews().customText(
          textContent: 'Shopping Cart',
          fontSize: AppSize.titleText,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Consumer<CartController>(
        builder: (context, controller, child) {
          if (controller.cartItems.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.pagePadding,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(
                      AppSize.productCardRadius,
                    ),
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
                            color: AppColors.primaryColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 9.w,
                          color: AppColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: AppSize.mediumSpacing),

                      CommonViews().customText(
                        textContent: 'Your cart is empty',
                        textAlign: TextAlign.center,
                        fontSize: AppSize.titleText,
                        fontWeight: FontWeight.w700,
                      ),

                      SizedBox(height: AppSize.smallSpacing),

                      CommonViews().customText(
                        textContent:
                        'Looks like you haven\'t added any products yet. Start shopping and your items will appear here.',
                        textAlign: TextAlign.center,
                        fontSize: AppSize.mediumText,
                        textColor: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(
                    AppSize.pagePadding,
                  ),
                  itemCount: controller.cartItems.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: AppSize.smallSpacing),
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];

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
                      child: Row(
                        children: [
                          AppCachedImage(
                            imageUrl: item.image,
                            width: 22.w,
                            height: 22.w,
                            radius: 10,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(width: 3.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CommonViews().customText(
                                  textContent: item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: AppSize.bodyText,
                                  fontWeight: FontWeight.w600,
                                ),

                                SizedBox(
                                  height: .5.h,
                                ),

                                CommonViews().customText(
                                  textContent:
                                  '\$${item.price.toStringAsFixed(2)}',
                                  fontSize: AppSize.bodyText,
                                  fontWeight: FontWeight.w700,
                                  textColor:
                                  AppColors.primaryColor,
                                ),

                                SizedBox(
                                  height: AppSize.smallSpacing,
                                ),

                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity(item);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                    ),

                                    CommonViews().customText(
                                      textContent:
                                      item.quantity.toString(),
                                      fontWeight: FontWeight.bold,
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(item);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              controller.removeProduct(item.id);
                            },
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.errorColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(
                  AppSize.pagePadding,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        CommonViews().customText(
                          textContent: 'Total',
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.titleText,
                        ),
                        CommonViews().customText(
                          textContent:
                          '\$${controller.totalPrice.toStringAsFixed(2)}',
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.titleText,
                          textColor: AppColors.primaryColor,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: AppSize.mediumSpacing,
                    ),

                    CommonViews().customButton(
                      onTap: () async {
                        await context.read<CartController>().clearCart();

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text('Cart cleared successfully'),
                                  ),
                                ],
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.primaryColor,
                              duration: Duration(seconds: 2),
                            ),
                          );
                      },
                      child: CommonViews().customText(
                        textContent: 'Clear Cart',
                        textColor: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}