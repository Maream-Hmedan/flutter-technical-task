import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/constant_values.dart';
import 'package:flutter_technical_task/screens/product/model/product_response.dart';
import 'package:flutter_technical_task/screens/product/repository/product_repository.dart';
import 'package:flutter_technical_task/utils/helpers/general.dart';

enum ApiStatus { loading, empty, error, success }

class ProductController extends ChangeNotifier {
  ProductController({required ProductRepository repository})
    : _repository = repository;

  final ProductRepository _repository;

  ApiStatus apiStatus = ApiStatus.loading;

  List<ProductResponse> products = [];
  List<ProductResponse> filteredProducts = [];
  final Set<int> favoriteIds = <int>{};

  String errorMessage = '';
  String searchQuery = '';

  Future<void> getProducts() async {
    apiStatus = ApiStatus.loading;
    errorMessage = '';
    notifyListeners();

    try {
      products = await _repository.getProducts();
      filteredProducts = List<ProductResponse>.from(products);

      apiStatus = products.isEmpty ? ApiStatus.empty : ApiStatus.success;
    } catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');

      apiStatus = ApiStatus.error;
    }

    notifyListeners();
  }

  Future<void> refreshProducts() async {
    apiStatus = ApiStatus.loading;
    errorMessage = '';
    notifyListeners();

    try {
      products = await _repository.getProducts();

      _applySearch();

      apiStatus = products.isEmpty
          ? ApiStatus.empty
          : ApiStatus.success;
    } catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      apiStatus = ApiStatus.error;
    }

    notifyListeners();
  }

  void searchProducts(String value) {
    searchQuery = value.trim();
    _applySearch();
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    filteredProducts = List<ProductResponse>.from(products);
    notifyListeners();
  }


  void _applySearch() {
    if (searchQuery.isEmpty) {
      filteredProducts = List<ProductResponse>.from(products);
      return;
    }

    final String query = searchQuery.toLowerCase();

    filteredProducts = products.where((product) {
      return product.title.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> loadFavorites() async {
    final List<String> savedIds = await General.getPrefStringList(
      ConstantValues.favoriteProductIds,
    );

    favoriteIds
      ..clear()
      ..addAll(
        savedIds.map(int.parse),
      );

    notifyListeners();
  }

  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  List<ProductResponse> get favoriteProducts {
    return products
        .where(
          (product) => favoriteIds.contains(product.id),
    )
        .toList();
  }

  Future<void> toggleFavorite(int productId) async {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }

    await General.savePrefStringList(
      ConstantValues.favoriteProductIds,
      favoriteIds.map((id) => id.toString()).toList(),
    );

    notifyListeners();
  }
}
