import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/boxshadow_widget.dart';
import 'package:sizer/sizer.dart';

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
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.scaffoldBackgroundColor,
            title: Text(
              "My Cart",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppColors.scaffoldBackgroundColor,
            child: AppButton(color: AppColors.blueLightCambridge, text: "Go to Check out" " ${cartController.cartValue?.meta?.totalPrice}\$",textStyle: TextStyle(fontSize: 20,color: AppColors.whiteAppColor),),
          ),
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
                          color: AppColors.darkPurpleColor,
                          text: "Giriş Yapın"),
                    )
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: List.generate(
                          cartController.cartValue?.data?.length ?? 0, (index) {
                        var product = cartController.cartValue?.data?[index];
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 5, left: 5, top: 20),
                          child: Container(
                            height: 15.h,
                            decoration: BoxDecoration(
                                color: AppColors.scaffoldBackgroundColor,
                                boxShadow: [BoxShadowWidget.light],
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                      height: 100,
                                      width: 100,
                                      "${product?.imageUrl}"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${product?.name}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColors.whiteAppColor,
                                              border: Border.all(
                                                  color: AppColors
                                                      .greyBorderColor),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color:
                                                  AppColors.blueDarkCambridge,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          GetBuilder<CartController>(
                                            // Wrap in GetBuilder to update when cart changes
                                            builder: (_) =>
                                                Text("${product?.quantity}"),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColors.whiteAppColor,
                                              border: Border.all(
                                                  color: AppColors
                                                      .greyBorderColor),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                cartController.addProductToCart(
                                                    productId:
                                                        "${product?.productId}");
                                                cartController.fetchCartItems();
                                                cartController
                                                    .update(); // Update the CartController state
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: AppColors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text(
                                        "${product?.totalPrice}₺",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }
          }));
    });
  }
}
