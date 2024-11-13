import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/controllers/categories&products_controller.dart';
import 'package:grocery_app/routes/app_names.dart';
import 'package:grocery_app/ui/widgets/boxshadow_widget.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartController>(
        builder: (cartController) {
          return GetBuilder<CategoriesController>(
              builder: (controller) {
                final categoryInfo = controller.ProductsByCategory?.data?.category;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      pinned: true,
                      backgroundColor: AppColors.blueLightCambridge,
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.cartScreen);
                            cartController.fetchCartItems();
                          },
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: AnimatedOpacity(
                          opacity: 1.0, // Optional: Smooth opacity effect during scrolling
                          duration: Duration(milliseconds: 300),
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Align(
                              child: Text(
                                '${categoryInfo?.name}',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              "${categoryInfo?.imageUrl}",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items per row
                          mainAxisSpacing: 16.0, // Vertical spacing between items
                          crossAxisSpacing: 16.0, // Horizontal spacing between items
                          childAspectRatio: 0.70, // Adjust for taller items
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            var products = controller.ProductsByCategory?.data?.products?[index];
                            return InkWell(
                              onTap: (){
                                controller.fetchProductDetail("${products?.id}");
                                Get.toNamed(AppRoutes.productDetail);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  //boxShadow: [BoxShadowWidget.medium],
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.whiteAppColor,
                                  boxShadow: [BoxShadowWidget.light]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          "${products?.imageUrl}",
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                        child: Text("${products?.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("${products?.feature}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),
                                      ),
                                      SizedBox(height: 30,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("\$""${products?.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                            InkWell(
                                              onTap: (){
                                                cartController.addProductToCart(productId: "${products?.id}");
                                              },
                                              child: Container(
                                                width: 42,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                  shape:BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: AppColors.green,
                                                ),
                                                child: Icon(Icons.add,color: AppColors.whiteAppColor,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                  ),
                                )
                              ),
                            );
                          },
                          childCount: controller.ProductsByCategory?.data?.products?.length ?? 0 // Number of grid items
                        ),
                      ),
                    ),
                  ],
                );
              }
          );
        }
      ),
    );
  }
}

