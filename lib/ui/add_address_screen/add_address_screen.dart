import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/controllers/AddressesController.dart';
import 'package:grocery_app/routes/app_names.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/GoogleMapsController.dart';
import '../../controllers/AuthController.dart';
import '../../utils/app_colors.dart';


class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AddressController addressController = Get.put(AddressController());
  final AddressesController addressesController =
  Get.find<AddressesController>();

  final GlobalKey<FormState> _adressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
        centerTitle: true,
        backgroundColor: AppColors.blueLightCambridge,
      ),
      body: GetBuilder<AddressController>(
        builder: (_) {
          return GetBuilder<AuthorizationController>(
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 35.h,
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          addressController.mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(36.577356, 36.154813),
                          zoom: 14,
                        ),
                        onTap: (LatLng position) {
                          addressController.onMapTapped(position);
                          addressesController.update();
                        },
                        markers: Set<Marker>.of(addressController.markers),
                        gestureRecognizers: Set()
                          ..add(Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer()))
                          ..add(Factory<ScaleGestureRecognizer>(
                                  () => ScaleGestureRecognizer()))
                          ..add(Factory<TapGestureRecognizer>(
                                  () => TapGestureRecognizer()))
                          ..add(Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer())),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Haritaya dokunarak enlem ve boylam otomatik doldurulacaktır.',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          SizedBox(height: 2.h),
                          Form(
                            key: _adressFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: addressesController.addressMarkerController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_pin, color: Colors.grey),
                                    hintText: 'Adres Adı',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty ? 'Lütfen adres adı giriniz' : null,
                                ),
                                SizedBox(height: 2.h),
                                TextFormField(
                                  controller: addressesController.postCodeController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.local_post_office, color: Colors.grey),
                                    hintText: 'Posta Kodu',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty ? 'Lütfen posta kodu giriniz' : null,
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: addressesController.addressNameController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                                          hintText: 'İsim',
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        validator: (value) => value!.isEmpty ? 'Lütfen isim giriniz' : null,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                TextFormField(
                                  controller: addressesController.addressInfoController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.home, color: Colors.grey),
                                    hintText: 'Adres Bilginiz',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty ? 'Lütfen adres bilgisi giriniz' : null,
                                ),
                                SizedBox(height: 4.h),
                                Center(
                                  child: GetBuilder<AddressesController>(
                                    builder: (controller) {
                                      return GestureDetector(
                                        onTap: (){
                                      if (_adressFormKey.currentState!.validate()) {
                                      controller.newAddress();
                                      controller.addressInfoController.clear();
                                      controller.addressMarkerController.clear();
                                      controller.addressNameController.clear();
                                      controller.fetchAddresses();
                                      Get.toNamed(AppRoutes.navBarScreen);
                                      }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(vertical: 12),
                                          decoration: BoxDecoration(
                                            color: controller.isLoading
                                                ? Colors.grey // Dimmed color when loading
                                                : AppColors.turquoiseColor,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.turquoiseColor.withOpacity(0.5),
                                                blurRadius: 6,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: controller.isLoading
                                                ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.0,
                                              ),
                                            )
                                                : Text(
                                              "Add Address",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
