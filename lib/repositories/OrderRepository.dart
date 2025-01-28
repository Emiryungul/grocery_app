import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class OrderRepository {
  final ApiService apiService;

  OrderRepository({required this.apiService});

  Future<http.Response> fetchOrderItems() async {
    final response = await apiService.getRequest(
        '/order-history',
        withAuth: true
    );
    debugPrint(response.body);
    print(response.body);
    return response;
  }

}