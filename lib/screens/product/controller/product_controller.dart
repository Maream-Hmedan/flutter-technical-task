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

  String errorMessage = '';

  Future<void> getProducts() async {
    apiStatus = ApiStatus.loading;
    errorMessage = '';
    notifyListeners();

    try {
      products = await _repository.getProducts();

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

      apiStatus = products.isEmpty ? ApiStatus.empty : ApiStatus.success;
    } catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');

      apiStatus = ApiStatus.error;
    }

    notifyListeners();
  }
}
