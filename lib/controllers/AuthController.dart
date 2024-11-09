import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/AuthRepository.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';
import 'CartController.dart';

class AuthorizationController extends GetxController {
  final AuthorizationRepository authorizationRepository;
  final TokenStorage tokenStorage = TokenStorage();

  AuthorizationController({Key? key, required this.authorizationRepository});



  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _token = Rxn<String>();
  var emailController = TextEditingController();
  var addressEmailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  bool get isLoading => _isLoading.value;

  User? get user => _user.value;

  String? get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    everAll([_token], _redirectBasedOnAuthStatus);
    _checkAuthenticationStatus();

  }
  Future<void> authenticate() async {
    _isLoading.value = true;
    try {
      final response = await authorizationRepository.login(
          emailController.text, passwordController.text);
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = response.body;
        final authorizationModel = userModelFromJson(responseBody);
        // Update the user and token in the controller
        _user.value = authorizationModel.user;
        debugPrint(responseBody);
          if (authorizationModel.token!= null) {
            await tokenStorage.saveToken(authorizationModel.token!);
            _token.value = authorizationModel.token;
            debugPrint("TOKEN: ${_token.value}");
            Get.back();
            Get.snackbar('Başarılı', "${_user.value?.email}"' Hesabınıza Giriş Yaptınız');
          }
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Dikkat !', "Bu Bilgiler Sistemimizde Bulunmamakta");
      }
    } catch (e) {
      Get.snackbar('Hata', 'Lütfen bilgilerinizi kontrol ediniz');
    } finally {
      _isLoading.value = false;
    }
  }
  Future<void> getUser() async {
    _isLoading.value = true;
    try {
      final response = await authorizationRepository.user();
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = response.body;
        final authorizationModel = userModelFromJson(responseBody);
        // Update the user in the controller
        _user.value = authorizationModel.user;
        print(_user.value?.name);
        print(_user.value?.email);
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', '${e}');
    } finally {
      update();
      _isLoading.value = false;
    }
  }

  Future<void> _checkAuthenticationStatus() async {
    final token = await tokenStorage.getToken();
    if (token != null) {
      // Token exists, update the token
      _token.value = token;
    }
  }
  void _redirectBasedOnAuthStatus(dynamic _) async{
    if (_token.value != null) {
      // User is authenticated
      debugPrint("Redirecting");
      print(_token.value);
      Get.find<CartController>().fetchCartItems();
      getUser();
    } else {
      // User is not authenticated
    }
  }
}