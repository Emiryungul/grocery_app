import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class CartRepository {
  final ApiService apiService;

  CartRepository({required this.apiService});

  Future<http.Response> fetchCartItems() async {
    final response = await apiService.getRequest(
        '/cart',
        withAuth: true
    );
    debugPrint(response.body);
    print(response.body);
    return response;
  }

  Future<http.Response> deleteCartItem(String id) async {
    final response = await apiService.deleteRequest(
        '/cart/$id',
        withAuth: true
    );
    debugPrint(response.body);
    print(response.body);
    return response;
  }

  Future<http.Response> addProductToCart({
    required String productId,
  }) async {
    final body = {
      'product_id': productId,
    };
    debugPrint(body.toString());
    final response = await apiService.postRequest(
        '/cart',
        body: body,
        withAuth: true

    );
    debugPrint(response.body);
    return response;
  }

  Future<http.Response> payForTheCart({
    required String addressId,
  }) async {
    final body = {
      'address_id': addressId,
    };
    debugPrint(body.toString());
    final response = await apiService.postRequest(
        '/cart/pay',
        body: body,
        withAuth: true

    );
    debugPrint(response.body);
    return response;
  }


}