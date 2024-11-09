import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grocery_app/controllers/AuthController.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/repositories/AuthRepository.dart';
import 'package:grocery_app/repositories/CartRepository.dart';
import 'package:grocery_app/repositories/categories&products_repository.dart';
import 'package:grocery_app/routes/app_pages.dart';
import 'package:grocery_app/services/api_service.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/utils/token_storage.dart';
import 'package:sizer/sizer.dart';

import 'controllers/categories&products_controller.dart';


void main() async{
  runApp(const MyApp());
  final apiService = ApiService(
      baseUrl: 'http://10.0.2.2:8000/api',
      commonHeaders: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      tokenStorage: TokenStorage());

  final CategoriesRepository categoriesRepository =
  CategoriesRepository(apiService: apiService);
  Get.put(CategoriesController(categoriesRepository: categoriesRepository));

  final CartRepository cartRepository =
  CartRepository(apiService: apiService);
  Get.put(CartController(cartRepository: cartRepository));

  final AuthorizationRepository authorizationRepository =
  AuthorizationRepository(apiService: apiService);
  Get.put(AuthorizationController(authorizationRepository: authorizationRepository));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext , Orientation , ScreenType ) { return GetMaterialApp(
        title: 'Flutter Demo',
        getPages: AppPages.pages,
        initialRoute: '/',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          //textTheme: AppTextThemes.poppinsTextTheme,
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        ),
      ); },

    );
  }
}

