import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'AuthController.dart';


class AddressController extends GetxController {
  var markers = <Marker>[].obs; // Store markers

  late GoogleMapController mapController;
  final authorizationController = Get.find<AuthorizationController>(); // Use Get.find to find AuthorizationController

  // This method is called when the map is tapped
  void onMapTapped(LatLng position) async {
    // Update the latitude and longitude in the AuthorizationController
    authorizationController.latitudeController.text = position.latitude.toString();
    authorizationController.longitudeController.text = position.longitude.toString();

    // Perform reverse geocoding to get a human-readable address
    String address = await getAddressFromLatLng(position.latitude, position.longitude);
    authorizationController.addressInfoController.text = address;

    // Add or update marker with the address in the snippet
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('selected-location'),
        position: position,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: 'Address: $address',
        ),
      ),
    );
    update();
  }

  // Function to perform reverse geocoding
  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  // Dispose resources if needed
  @override
  void onClose() {
    super.onClose();
  }
}
