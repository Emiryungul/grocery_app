import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grocery_app/ui/home_screen/home_screen.dart';


import 'app_names.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreen(),
    ),
    ];
}