import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AddressesController.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/appbutton_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_colors.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
          return BottomAppBar(
            color: Colors.white,
            elevation: 1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Text("Sum",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("${cartController.cartValue?.meta?.totalPrice}\$",style: TextStyle(color: AppColors.blueTiffany,fontSize: 18),),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  child: Container(
                    width: 60.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: AppColors.blueTiffany,
                        borderRadius: BorderRadius.circular(35)
                    ),
                    child: Center(child: Text("Pay Now",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                )
              ],
            ),
          );
        }
      ),
      appBar: AppBar(
        backgroundColor: AppColors.blueLightCambridge,
        centerTitle: true,
        title: Text("CheckOut Screen"),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CartController>(builder: (cartController) {
          return GetBuilder<AddressesController>(builder: (addressController) {
            var product = addressController.selectedAddress.value;
            return Column(
              children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     width: 100.w,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(12),
                       color: AppColors.whiteAppColor,
                       border: Border.all(
                         color: Colors.grey.shade300, // Border color
                         width: 1.5, // Border width
                       ),
                     ),
                     child:  Padding(
                         padding: EdgeInsets.only(left: 15, top: 15),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Delivery Address",style: TextStyle(fontWeight: FontWeight.bold),),
                         Container(
                           height: 1, // Line height
                           width: 90.w, // Full width
                           color: Colors.grey.shade500, // Line color
                         ),
                         //SizedBox(height: 10,),
                         Row(
                           children: [
                             Padding(
                               padding: EdgeInsets.only(right: 0),
                               child: GestureDetector(
                                 onTap: () {
                                   final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${addressController.selectedAddress.value?.lat},${addressController.selectedAddress.value?.lon}';
                                   if (canLaunch(googleMapsUrl) != null) {
                                     launch(googleMapsUrl);
                                   } else {
                                     // Handle the case where the URL can't be opened
                                     print('Could not open Google Maps.');
                                   }
                                 },
                                 child: Image.network(
                                   'https://maps.googleapis.com/maps/api/staticmap?center=${addressController.selectedAddress.value?.lat},${addressController.selectedAddress.value?.lat}&zoom=15&size=100x100&markers=color:red%7C${addressController.selectedAddress.value?.lat},${addressController.selectedAddress.value?.lon}&key=AIzaSyB94IrgQ6wpH_f2jOW5dXSCOZ-ExQ35zSw',
                                   //fit: BoxFit.cover,
                                   width: 25.w,
                                   height: 15.h,
                                 ),
                               ),
                             ),
                             SizedBox(width: 12,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("${product?.name}",style: TextStyle(fontWeight: FontWeight.bold),),
                                 SizedBox(height: 5,),
                                 Text("${product?.address}",style: TextStyle(fontWeight: FontWeight.w400),),
                                 SizedBox(height: 5,),
                                 Text("${product?.marker}",style: TextStyle(fontWeight: FontWeight.w600),),
                               ],
                             )
                           ],
                         ),
                       ],
                     ),
                     )
                   ),
                 ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteAppColor,
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 1.5, // Border width
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Summary",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1, // Line height
                            width: 90.w, // Full width
                            color: Colors.grey.shade500, // Line color
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                              children: List.generate(
                                  cartController.cartValue?.data?.length ?? 0,
                                  (index) {
                            var product =
                                cartController.cartValue?.data?[index];
                            return Row(
                              children: [
                                Text("${product?.quantity}""x "),
                                Text("${product?.name}",style: TextStyle(fontWeight: FontWeight.bold),),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text("${product?.price}"),
                                ),

                              ],
                            );
                          })),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1, // Line height
                            width: 90.w, // Full width
                            color: Colors.grey.shade300, // Line color
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Sum",style: TextStyle(fontWeight: FontWeight.bold),),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text("${cartController.cartValue?.meta?.totalPrice}\$"),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteAppColor,
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 1.5, // Border width
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment Choices",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Container(
                            height: 1, // Line height
                            width: 90.w, // Full width
                            color: Colors.grey.shade400, // Line color
                          ),
                          SizedBox(height: 15,),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          });
        }),
      ),
    );
  }
}
