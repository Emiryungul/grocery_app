import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../repositories/categories&products_repository.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';
import '../models/categories_model.dart' as categories;
import '../models/allproducts_model.dart' as products;
import '../models/products_by_category_model.dart' as category_products;

class CategoriesController extends GetxController{
  final CategoriesRepository categoriesRepository;
  final TokenStorage tokenStorage = TokenStorage();

  CategoriesController({Key? key ,required this.categoriesRepository});
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  final Rxn<categories.CategoriesModel> _category =
  Rxn<categories.CategoriesModel>();
  final Rxn<products.AllProductsModel> _products =
  Rxn<products.AllProductsModel>();

  final Rxn<category_products.ProductsByCategoryModel> _categorysProducts =
  Rxn<category_products.ProductsByCategoryModel>();

  categories.CategoriesModel? get category => _category.value;
  products.AllProductsModel? get Products => _products.value;
  category_products.ProductsByCategoryModel? get ProductsByCategory => _categorysProducts.value;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchAllProducts();
  }


  Future<void> fetchCategories() async {
    _isLoading.value = true;
    try {
      final response = await categoriesRepository.fetchCategories();
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        // Parse the response body
        final responseBody = response.body;
        final categoriesModel = categories.categoriesModelFromJson(responseBody);
        // Update the user and token in the controller
        _category.value = categoriesModel;
        debugPrint(responseBody);

        print("*****************");
        print(category?.toJson());
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', "$e");
      print("$e");
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> fetchAllProducts() async {
    _isLoading.value = true;
    try {
      final response = await categoriesRepository.fetchAllProducts();
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        // Parse the response body
        final responseBody = response.body;
        final productsModel = products.allProductsModelFromJson(responseBody);
        // Update the user and token in the controller
        _products.value = productsModel;
        debugPrint(responseBody);

        print("*****************");
        print(Products?.toJson());
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', "$e");
      print("$e");
    } finally {
      _isLoading.value = false;
      update();
    }
  }
  Future<void> fetchProductsByCategory(int id) async {
    _isLoading.value = true;
    try {
      final response = await categoriesRepository.fetchProductsByCategory(id);
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        // Parse the response body
        final responseBody = response.body;
        final categoryProductsModel = category_products.productsByCategoryModelFromJson(responseBody);
        // Update the user and token in the controller
        _categorysProducts.value = categoryProductsModel ;
        debugPrint(responseBody);


      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', "$e");
      print("$e");
    } finally {
      _isLoading.value = false;
      update();
    }
  }

}