import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';

import '../../controllers/AuthController.dart';
import '../../routes/app_names.dart';
import '../../utils/app_colors.dart';
import '../widgets/appbutton_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Scaffold(
          body: GetBuilder<AuthorizationController>(builder: (controller) {
            if (controller.token == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sepete Erişmek İçin Giriş Yapınız",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.loginScreen);
                      },
                      child: AppButton(
                          color: AppColors.darkPurpleColor, text: "Giriş Yapın"),
                    )
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
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
              );
            }
          }));
    });
  }
}
