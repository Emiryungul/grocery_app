import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AddressesController.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: GetBuilder<AddressesController>(
          builder: (controller) {
            return Column(
              children: List.generate(controller.userAddress?.addresses?.length ?? 0,
                  (index){
                var product = controller.userAddress?.addresses?[index];
                return Container(
                  child: Text("${product?.address}"),
                );
                  })
            );
          }
        ),
      ),
    );
  }
}
