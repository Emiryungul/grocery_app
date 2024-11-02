import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(

              children: List.generate(cartController.cartValue?.data?.length ?? 0,
                  (index){
                var product = cartController.cartValue?.data?[index];
                return Container(
                  child: Center(child: Text("${product?.quantity}")),
                );
                  }
              ),
            ),
          ),
        );
      }
    );
  }
}
