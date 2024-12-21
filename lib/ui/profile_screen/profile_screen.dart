import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AddressesController.dart';
import 'package:grocery_app/controllers/AuthController.dart';

import '../../routes/app_names.dart';
import '../../utils/app_colors.dart';
import '../widgets/profile_container_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthorizationController>(
      builder: (authController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.scaffoldBackgroundColor,
            title: Text("Profile",style: TextStyle(fontSize: 24),),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Container(
                      height: 140.0,
                      width: 140.0,
                      decoration: const BoxDecoration(
                          color: AppColors.greyShipColor,
                          shape: BoxShape.circle),
                      child:
                           const Icon(Icons.person,
                          color: Colors.white, size: 80),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (authController.token != null) ...[
                        Text(
                          "${authController.userValue?.name}",
                          style: TextStyle(
                            color: AppColors.blackAppColor,
                            fontWeight: FontWeight.w400,
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
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8,left: 8,top: 20),
                  child: ProfileSettingWidget(
                    ContainerColor: AppColors.green,
                    icon: Icons.add_chart,
                    IconColor: AppColors.whiteAppColor,
                    text: "Shop History",
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.whiteAppColor),
                    func: () {
                      if(authController.token == null){
                        Get.toNamed(AppRoutes.loginScreen);
                      }
                      else{
                        //categoryController.fetchReservationHistory();
                        //Get.toNamed(AppRoutes.orderHistory);
                      }
                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8,left: 8,top: 15),
                  child: GetBuilder<AddressesController>(
                    builder: (controller) {
                      return ProfileSettingWidget(
                        ContainerColor: AppColors.green,
                        icon: Icons.location_on,
                        IconColor: AppColors.whiteAppColor,
                        text: "Addresses",
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.whiteAppColor),
                        func: () {
                          if(authController.token == null){
                            Get.toNamed(AppRoutes.loginScreen);
                          }
                          else{
                            controller.fetchAddresses();
                            Get.toNamed(AppRoutes.addressesScreen);
                          }
                        },
                      );
                    }
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8,left: 8,top: 15),
                  child: ProfileSettingWidget(
                    ContainerColor: AppColors.green,
                    icon: Icons.pages_rounded,
                    IconColor: AppColors.whiteAppColor,
                    text: "Terms and Services",
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.whiteAppColor),
                    func: () {
                      if(authController.token == null){
                        Get.toNamed(AppRoutes.loginScreen);
                      }
                      else{
                        //categoryController.fetchReservationHistory();
                        //Get.toNamed(AppRoutes.orderHistory);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8,left: 8,top: 15),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          if(authController.token != null){
                            authController.logOut();
                          }
                          else{
                            Get.toNamed(AppRoutes.loginScreen);
                          }
                        },child: Text(authController.token != null ? "Çıkıs Yap" : "Giris Yap",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.black),)),
                        Icon(Icons.power_settings_new,color: Colors.red,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
