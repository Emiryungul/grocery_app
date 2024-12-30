import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class AddressesRepository {
  final ApiService apiService;

  AddressesRepository({required this.apiService});

  Future<http.Response> addAddress(
      {required String name,
        required String address,
        required String marker,
        required double latitude,
        required double longitude,
        required String postCode}) async {
    final body = {
      'name': name,
      'address': address,
      'marker': marker,
      'lat': latitude,
      'lon': longitude,
      'post_code': postCode
    };

    debugPrint(body.toString());
    final response =
    await apiService.postRequest('/addresses', body: body, withAuth: true);
    debugPrint(response.body);
    return response;
  }

  Future<http.Response> fetchAddresses() async {
    final response = await apiService.getRequest(
        '/addresses',
        withAuth: true
    );
    debugPrint(response.body);
    print(response.body);
    return response;
  }

  Future<http.Response> deleteAddress(String id) async {
    final response = await apiService.deleteRequest(
        '/addresses/$id',
        withAuth: true
    );
    debugPrint(response.body);
    print(response.body);
    return response;
  }

}
