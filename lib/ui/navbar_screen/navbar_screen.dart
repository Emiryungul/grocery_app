import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/ui/cart_screen/cart_screen.dart';
import 'package:grocery_app/ui/home_screen/home_screen.dart';
import 'package:grocery_app/ui/restaurants_screen/restaurants_screen.dart';


class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  void _navigateBottomNavBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    RestaurantsScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedItemColor: Colors.green.shade600,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        elevation: 10,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Restaurant',
              backgroundColor: Colors.black
          ),
        ],
      ),

    );

  }
}