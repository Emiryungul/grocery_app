import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/controllers/FavoritesController.dart';
import 'package:grocery_app/ui/cart_screen/cart_screen.dart';
import 'package:grocery_app/ui/favorites_screen/favorites_screen.dart';
import 'package:grocery_app/ui/home_screen/home_screen.dart';
import 'package:grocery_app/ui/restaurants_screen/restaurants_screen.dart';

import '../../controllers/CartController.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}
final CartController cartController = Get.find<CartController>(); // Initialize your controller
final FavoritesController favoritesController = Get.find<FavoritesController>(); // Again initialize

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    FavoritesScreen(),
  ];

  final Map<int, Function> _itemActions = {
    0: () {
      // Perform an action for Home
      print("Home selected");
    },
    1: () {
      cartController.fetchCartItems();
      print("Cart selected");
    },
    2: () {
      favoritesController.fetchFavoriteItems();
      print("Favorites selected");
    },
  };

  void _navigateBottomNavBar(int index) {
    // Call the function associated with the tapped item
    if (_itemActions[index] != null) {
      _itemActions[index]!();
    }

    // Update the selected index to show the correct page
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedItemColor: Colors.green.shade600,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurant',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
