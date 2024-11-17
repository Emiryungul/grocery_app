import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AuthController.dart';

import '../../routes/app_names.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthorizationController>(
      builder: (authController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          if(authController.token != null){
                            authController.logOut();
                          }
                          else{
                            Get.offAllNamed(AppRoutes.loginScreen);
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
