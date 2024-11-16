import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/controllers/categories&products_controller.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/appbutton_widget.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_names.dart';
import '../../utils/app_colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        return GetBuilder<CategoriesController>(builder: (categoriesController) {
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
                  onPressed: () {},
                ),
              ],
            ),
            bottomNavigationBar: InkWell(
              onTap: (){
                cartController.addProductToCart(productId: "${product?.id}");
                Get.snackbar('Cart', "This product is added");
              },
              child: BottomAppBar(
                color: AppColors.scaffoldBackgroundColor,
                child: AppButton(color: AppColors.blueLightCambridge, text: "Add to Cart"),
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
                                fontSize: 19,
                                fontWeight: FontWeight.bold)),
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
                                style: TextStyle(color: AppColors.redColor,
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          "${product?.description}",
                          style: TextStyle(
                              color: AppColors.greyShipColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30,),
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
                                borderRadius:
                                BorderRadius.circular(12), // Rounded corners
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
                                borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${product?.expiration}',
                                      style: TextStyle(
                                        color: AppColors.blueDark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Expiration',
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
                                borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${product?.energy}',
                                      style: TextStyle(
                                        color: AppColors.redColor,
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
                              width: 180,
                              height: 90,
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldBackgroundColor,
                                border: Border.all(
                                  color: Colors.grey.shade300, // Border color
                                  width: 1.5, // Border width
                                ),
                                borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${product?.feature}',
                                      style: TextStyle(
                                        color: AppColors.blueDark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Feature',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
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
      }
    );
  }
}
class DomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}