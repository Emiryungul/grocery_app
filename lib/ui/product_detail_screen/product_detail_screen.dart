import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/controllers/FavoritesController.dart';
import 'package:grocery_app/controllers/categories&products_controller.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/appbutton_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../routes/app_names.dart';
import '../../utils/app_colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return GetBuilder<FavoritesController>(builder: (favoriteController) {
        return GetBuilder<CategoriesController>(
            builder: (categoriesController) {
          var product = categoriesController.productDetail;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.blueLightCambridge,
              centerTitle: true,
              title: Text("Product Detail"),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    favoriteController.addFavoriteItem("${product?.id}");
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: AppColors.scaffoldBackgroundColor,
              child: InkWell(
                onTap: (product?.stock ?? 0) > 0
                    ? () {
                  cartController.addProductToCart(productId: "${product?.id}");
                  Get.snackbar(
                    'Success',
                    'Product is added to the cart x1',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.greenLime,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(10),
                    borderRadius: 8,
                    duration: const Duration(seconds: 3),
                  );
                }
                    : null, // Non-clickable when stock is 0
                child: AppButton(
                  color: (product?.stock ?? 0) > 0
                      ? AppColors.blueLightCambridge
                      : AppColors.greyShipColor, // Change color if stock is 0
                  text: (product?.stock ?? 0) > 0 ? "Add to Cart" : "Out of Stock",
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.whiteAppColor,
                  ),
                ),
              ),
            ),

            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Custom Painted Dome Shape
                      ClipPath(
                        clipper: DomeClipper(),
                        child: Container(
                          height: 200.0,
                          color: AppColors.blueLightCambridge,
                        ),
                      ),
                      // Product Detail Content
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Image.network(
                            "${product?.imageUrl}", // Display product image
                            width: 180, // Adjust size as needed
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${product?.name}",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text("${product?.category?.name}",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("${product?.feature} , ",
                                style: TextStyle(
                                    color: AppColors.redColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Text("${product?.price}tl",
                                style: TextStyle(
                                    color: AppColors.redColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          "${product?.description}",
                          style: TextStyle(
                              color: AppColors.greyShipColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            Container(
                              width: 170,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBackgroundColor,
                                border: Border.all(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.5, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '100%',
                                      style: TextStyle(
                                        color: AppColors.greenLime,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Organic',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 170,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBackgroundColor,
                                border: Border.all(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.5, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${product?.expiration}',
                                      style: TextStyle(
                                        color: AppColors.greenLime,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Expiration',
                                      style: TextStyle(
                                        color: AppColors.greenLime,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 170,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBackgroundColor,
                                border: Border.all(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.5, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${product?.energy}',
                                      style: TextStyle(
                                        color: AppColors.greenLime,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Energy',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 170,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBackgroundColor,
                                border: Border.all(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.5, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Stock',
                                      style: TextStyle(
                                        color: AppColors.greenLime,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: LinearPercentIndicator(
                                        width: 100.0,
                                        lineHeight: 15.0,
                                        percent: product!.stock!/ 200, // Assuming 200 is the maximum stock level
                                        progressColor: product.stock! < 30
                                            ? Colors.red
                                            : (product.stock! < 100 ? Colors.orange : Colors.green),
                                        backgroundColor: Colors.grey.shade300,
                                        center: Text(
                                          "${product.stock}",
                                          style: TextStyle(color: Colors.black, fontSize: 10),
                                        ),
                                      ),
                                    )

                                    /*Text("Stock Numbers Are Low!!",style: TextStyle(
                                      color: product!.stock! < 15 ? Colors.red : Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),)*/
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
    });
  }
}

class DomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
