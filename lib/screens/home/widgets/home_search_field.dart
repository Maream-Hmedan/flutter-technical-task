import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_size.dart';
import 'package:flutter_technical_task/screens/product/controller/product_controller.dart';
import 'package:flutter_technical_task/utils/ui/common_views.dart';
import 'package:provider/provider.dart';

class HomeSearchField extends StatefulWidget {
  const HomeSearchField({super.key});

  @override
  State<HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends State<HomeSearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, productController, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.pagePadding,
          ),
          child: CommonViews().customTextField(
            controller: _searchController,
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: productController.searchQuery.isNotEmpty
                ? IconButton(
              onPressed: () {
                _searchController.clear();
                productController.clearSearch();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(Icons.close_rounded),
            )
                : null,
            onChanged: productController.searchProducts,
          ),
        );
      },
    );
  }
}