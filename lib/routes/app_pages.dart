import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grocery_app/models/products_by_category_model.dart';
import 'package:grocery_app/ui/home_screen/home_screen.dart';
import 'package:grocery_app/ui/navbar_screen/navbar_screen.dart';
import 'package:grocery_app/ui/product_detail_screen/product_detail_screen.dart';
import 'package:grocery_app/ui/products_by_category_screen/products_by_category_screen.dart';
import 'package:grocery_app/ui/restaurants_screen/restaurants_screen.dart';


import '../ui/cart_screen/cart_screen.dart';
import '../ui/login_screen/login_screen.dart';
import '../ui/profile_screen/profile_screen.dart';
import 'app_names.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.navBarScreen,
      page: () =>  NavbarScreen(),
    ),
    GetPage(
      name: AppRoutes.restaurantScreen,
      page: () =>  RestaurantsScreen(),
    ),
    GetPage(
      name: AppRoutes.productsScreen,
      page: () =>  ProductsByCategoryScreen(),
    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () =>  CartScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () =>  LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () =>  ProductDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () =>  ProfileScreen(),
    ),
    ];
}