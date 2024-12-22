import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AddressesController.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/boxshadow_widget.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_names.dart';
import '../../utils/app_colors.dart';
import '../widgets/appbutton_widget.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
        centerTitle: true,
        backgroundColor: AppColors.blueLightCambridge,
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.scaffoldBackgroundColor,
        child: InkWell(
          onTap: (){
            Get.toNamed(AppRoutes.addAddressesScreen);
          },
          child: AppButton(
          color: AppColors.blueLightCambridge,
          text: 'Add Address',
        )),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddressesController>(builder: (controller) {
          return Column(
              children: List.generate(
                  controller.userAddress?.addresses?.length ?? 0, (index) {
            var product = controller.userAddress?.addresses?[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadowWidget.light],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.location_on_outlined),
                      ),
                      Flexible(
                        child: Text("${product?.address}",
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.visible,
                            maxLines: 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }));
        }),
      ),
    );
  }
}
