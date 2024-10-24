import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/categories&products_controller.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
        GetBuilder<CategoriesController>(
            builder: (controller) {
              final categoryInfo = controller.ProductsByCategory?.data?.category;
              return Column(
                children: [
                  Text("${categoryInfo?.name}")
                ],
              );
            }
        ),
      ),
    );
  }
}

