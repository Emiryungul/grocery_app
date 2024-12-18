import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/repositories/AddressesRepository.dart';
import '../models/user_model.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';
import '../models/add_user_address_model.dart' as address ;
import '../models/show_user_addresses_model.dart' as user_addresses;

class AddressController extends GetxController {
  var markers = <Marker>[].obs;

  final AddressesRepository addressesRepository;
  final TokenStorage tokenStorage = TokenStorage();

  AddressController({Key? key, required this.addressesRepository});


  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _token = Rxn<String>();
  var nameController = TextEditingController();
  var addressInfoController = TextEditingController();
  var addressMarkerController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();
  var postCodeController = TextEditingController();

  bool get isLoading => _isLoading.value;

  User? get user => _user.value;

  String? get token => _token.value;

  final Rxn<address.AddUserAddressModel> _address =
  Rxn<address.AddUserAddressModel>();

  address.AddUserAddressModel? get addressValue => _address.value;

  final Rxn<user_addresses.ShowUserAddressesModel> _userAddresses =
  Rxn<user_addresses.ShowUserAddressesModel>();

  user_addresses.ShowUserAddressesModel? get userAddress => _userAddresses.value;

  Future<void> newAddress() async {
    _isLoading.value = true;
    try {
      update();
      final response = await addressesRepository.addAddress(
          name: nameController.text,
          address: addressInfoController.text,
          marker: addressMarkerController.text,
          latitude: double.parse(latitudeController.text),
          longitude: double.parse(longitudeController.text),
          postCode: postCodeController.text);
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = response.body;
        final addAddressModel = address.addUserAddressModelFromJson(responseBody);
        _address.value = addAddressModel;
        debugPrint(responseBody);
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'new address ${e}');
    } finally {
      update();
      _isLoading.value = false;
    }
  }

  Future<void> fetchAddresses() async {
    _isLoading.value = true;
    try {
      update();
      final response = await addressesRepository.fetchAddresses();
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = response.body;
        final showUserAddresses = user_addresses.showUserAddressesModelFromJson(responseBody);
        _userAddresses.value = showUserAddresses;
        debugPrint(responseBody);
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'new address ${e}');
    } finally {
      update();
      _isLoading.value = false;
    }
  }

  void onMapTapped(LatLng position) async {
    // Update the latitude and longitude in the AuthorizationController
    latitudeController.text = position.latitude.toString();
    longitudeController.text = position.longitude.toString();

    // Perform reverse geocoding to get a human-readable address
    String address = await getAddressFromLatLng(position.latitude, position.longitude);
    addressInfoController.text = address;

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