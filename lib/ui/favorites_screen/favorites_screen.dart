import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/controllers/FavoritesController.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/boxshadow_widget.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../widgets/appbutton_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Favorites"),
            backgroundColor: AppColors.scaffoldBackgroundColor,
          ),
          body: GetBuilder<FavoritesController>(
            builder: (favoriteController) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(favoriteController.favoritesValue?.favorites?.length ?? 0,
                      (index){
                    final product = favoriteController.favoritesValue?.favorites?[index].product;
                    return Column(
                      children: [
                        Container(
                          height: 1, // Line height
                          width: 90.w, // Full width
                          color: Colors.grey.shade500, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,left: 10,bottom: 5),
                          child: Container(
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: AppColors.whiteAppColor,
                              //borderRadius: BorderRadius.circular(9),
                              //boxShadow: [BoxShadowWidget.light],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    "${product?.imageUrl}"
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text("${product?.name}",style: TextStyle(fontSize: 20,color: AppColors.blueDark),),
                                    ),
                                    Text("${product?.feature}",style: TextStyle(fontSize:15,color: AppColors.blueDark),),

                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: (){
                                      cartController.addProductToCart(productId: "${product?.id}");
                                      Get.snackbar(
                                        'Success',
                                        'Product is added to the cart x1',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: AppColors.greenLime,
                                        colorText: Colors.white, // Adjust text color as needed
                                        margin: const EdgeInsets.all(10),
                                        borderRadius: 8,
                                        duration: const Duration(seconds: 3),
                                      );
                                    },
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape:BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.green,
                                      ),
                                      child: Icon(Icons.add,color: AppColors.whiteAppColor,),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),

                      ],
                    );
                      })
                ),
              );
            }
          ),
        );
      }
    );
  }
}
