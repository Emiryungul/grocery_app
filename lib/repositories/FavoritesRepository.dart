
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class FavoritesRepository {
  final ApiService apiService;

  FavoritesRepository({required this.apiService});

  Future<http.Response> addProductToFavorites({
    required String productId,
  }) async {
    final body = {
      'product_id': productId,
    };
    debugPrint(body.toString());
    final response = await apiService.postRequest(
        '/favorites',
        body: body,
        withAuth: true

    );
    debugPrint(response.body);
    return response;
  }

  Future<http.Response> addProductToCart() async {
    final response = await apiService.postRequest(
        '/favorites',
        withAuth: true
    );
    debugPrint(response.body);
    return response;
  }


}
