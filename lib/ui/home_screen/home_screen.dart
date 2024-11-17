import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AuthController.dart';
import 'package:grocery_app/ui/widgets/boxshadow_widget.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/categories&products_controller.dart';
import '../../routes/app_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class HomeScreen extends StatelessWidget {
  final List<String> imageList = [
    AppImages.shopsPNG,
    AppImages.restaurantPNG,
    AppImages.grocerysPNG,
  ];
  final List<String> categoriesList = [
    AppImages.applePNG,
    AppImages.broccoliPNG,
    AppImages.cheesePNG,
    AppImages.meatPNG,

  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthorizationController>(
      builder: (authController) {
        return GetBuilder<CategoriesController>(builder: (controller) {
          return Scaffold(
            body: Obx(() {
              if (controller.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(AppRoutes.profileScreen);
                            },
                            child: Container(
                              width: 13.w,
                              height: 13.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.whiteAppColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.person,),
                            ),

                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (authController.token != null) ...[
                              Text(
                                "${authController.userValue?.name}",
                                style: TextStyle(
                                  color: AppColors.blackAppColor,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Text(
                                "${authController.userValue?.email}",
                                style: TextStyle(
                                  color: AppColors.blackAppColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "Guest",
                                style: TextStyle(
                                  color: AppColors.blackAppColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ],
                        )

                        /* Spacer(),
                              Container(
                                width: 30.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                    color: AppColors.whiteAppColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),*/
                      ],
                    )),
                    SliverToBoxAdapter(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 25.h,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          viewportFraction: 0.8,
                        ),
                        items: imageList.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: 600,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:
                                    const BoxDecoration(color: AppColors.whiteAppColor),
                                child: Image.asset(
                                  imagePath,
                                  //fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 4.h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Categories",
                                style: TextStyle(
                                    color: AppColors.blackAppColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20)),
                            Text("SeeAll",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 17.h,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GetBuilder<CategoriesController>(
                                builder: (controller) {
                              return Row(
                                  children: List.generate(
                                      controller.category?.data?.length ?? 0,
                                      (index) {
                                var product = controller.category?.data?[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          controller
                                              .fetchProductsByCategory(product?.id ?? 0);
                                          Get.toNamed(AppRoutes.productsScreen);
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteAppColor,
                                              shape: BoxShape.circle,
                                            boxShadow: [BoxShadowWidget.light]
                                          ),
                                          child: Center(
                                            child: Image.network(
                                              "${product?.imageUrl}",
                                              fit: BoxFit.contain,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${product?.name}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                );
                              }));
                            })),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 10,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Products",
                                style: TextStyle(
                                    color: AppColors.blackAppColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20)),
                            Text("SeeAll",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: (9.5.w / 5.7.h)
                          ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final product = controller.Products?.data?[index];
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 10),
                              child: InkWell(
                                onTap: (){
                                  controller.fetchProductDetail("${product?.id}");
                                  Get.toNamed(AppRoutes.productDetail);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteAppColor,
                                      borderRadius: BorderRadius.circular(12),
                                        boxShadow: [BoxShadowWidget.light]
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Center(
                                            child: Image.network(
                                          "${product?.imageUrl}",
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 30),
                                          child: Text(
                                            "${product?.name}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Text(
                                            "${product?.feature}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppColors.redColor),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 7,),
                                              child: Container(
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  shape:BoxShape.circle,
                                                  color: AppColors.green,
                                                ),
                                                child: Icon(Icons.add,color: AppColors.whiteAppColor,),
                                              ),
                                            ),

                                          ],
                                        )
                                      ],
                                    )),
                              ));
                        },
                        childCount: controller.Products?.data?.length ?? 0, // Number of items in the grid
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
      }
    );
  }
}
