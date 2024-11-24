import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/repositories/CartRepository.dart';
import '../utils/app_colors.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';
import '../models/cart_model.dart' as cart;

class CartController extends GetxController{
  final CartRepository cartRepository;
  final TokenStorage tokenStorage = TokenStorage();

  CartController({Key? key ,required this.cartRepository});
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final Rxn<cart.CartModel> _cart =
  Rxn<cart.CartModel>();

  cart.CartModel? get cartValue => _cart.value;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> addProductToCart({required String productId}) async {
    _isLoading.value = true;
    try {
      final response = await cartRepository.addProductToCart(productId: productId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response body
        final responseBody = response.body;
        final cartModel = cart.cartModelFromJson(responseBody);
        // Update the user and token in the controller
        _cart.value = cartModel;
        debugPrint(responseBody);

        // Show a bottom snack bar

      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      //Get.snackbar('Error', "$e");
      print("$e");
    } finally {
      _isLoading.value = false;
      update();
    }
  }


  Future<void> fetchCartItems() async {
    _isLoading.value = true;
    try {
      final response = await cartRepository.fetchCartItems();
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        // Parse the response body
        final responseBody = response.body;
        final cartModel = cart.cartModelFromJson(responseBody);
        // Update the user and token in the controller
        _cart.value = cartModel;
        //debugPrint(responseBody);
        //print("*****************");
        //print(cartValue?.toJson());
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        //Get.snackbar('Error', error);
      }
    } catch (e) {
      //Get.snackbar('Error', "$e");
      print("$e");
    } finally {
      _isLoading.value = false;
      update();
    }
  }

}