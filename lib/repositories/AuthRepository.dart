import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class AuthorizationRepository {
  final ApiService apiService;

  AuthorizationRepository({required this.apiService});

  Future<http.Response> login(String email, String password) async {
    debugPrint("email: $email, password: $password");
    final body = {
      'email': email,
      'password': password,
    };

    final response = await apiService.postRequest(
      '/login',
      body: body,
    );
    debugPrint(response.body);
    return response;
  }
  Future<http.Response> user() async {
    final response = await apiService.getRequest('/user', withAuth: true);

    return response;
  }
}