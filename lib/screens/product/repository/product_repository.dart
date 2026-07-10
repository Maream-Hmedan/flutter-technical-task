import 'dart:convert';

import 'package:flutter_technical_task/configuration/api_end_point.dart';
import 'package:flutter_technical_task/screens/product/model/product_response.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductResponse>> getProducts() async {
    final http.Response response = await http.get(
      Uri.parse(ApiEndPoint.products),
      headers: const {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
      jsonDecode(response.body) as List<dynamic>;

      return jsonList
          .map(
            (dynamic item) => ProductResponse.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList();
    }

    throw Exception(
      'Failed to load products. Status code: ${response.statusCode}',
    );
  }
}