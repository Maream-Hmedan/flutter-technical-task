import 'package:flutter/material.dart';
import 'package:flutter_technical_task/screens/product/model/product_response.dart';
import 'package:flutter_technical_task/screens/product/repository/product_repository.dart';

enum ApiStatus { loading, empty, error, success }

class ProductController extends ChangeNotifier {
  ProductController({required ProductRepository repository})
    : _repository = repository;

  final ProductRepository _repository;

  ApiStatus apiStatus = ApiStatus.loading;

  List<ProductResponse> products = [];
  List<ProductResponse> filteredProducts = [];

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
}
