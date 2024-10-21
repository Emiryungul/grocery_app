import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../services/api_service.dart';

class CategoriesRepository {
  final ApiService apiService;

  CategoriesRepository({required this.apiService});

  Future<http.Response> fetchCategories() async {
    final response = await apiService.getRequest('/categories');
    debugPrint(response.body);
    print(response.body);
    return response;
  }
  Future<http.Response> fetchAllProducts() async {
    final response = await apiService.getRequest('/products');
    debugPrint(response.body);
    print(response.body);
    return response;
  }
}
