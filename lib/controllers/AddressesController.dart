import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/repositories/AddressesRepository.dart';
import '../models/add_user_address_model.dart' as address ;
import '../models/show_user_addresses_model.dart' as user_addresses;
import '../models/show_user_addresses_model.dart';
import '../models/user_model.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';

class AddressesController extends GetxController {
  final AddressesRepository addressesRepository;
  final TokenStorage tokenStorage = TokenStorage();

  AddressesController({Key? key, required this.addressesRepository});

  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _token = Rxn<String>();

  var addressNameController = TextEditingController();
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

  final Rxn<Addresss?> selectedAddress = Rxn<Addresss>();

  // A method to update the selected feature
  void updateSelectedAddress(Addresss? address) {
    selectedAddress.value = address;
    update();
  }

  @override
  void onInit(){
    super.onInit();
    fetchAddresses();
  }

  Future<void> newAddress() async {
    _isLoading.value = true;
    try {
      update();
      final response = await addressesRepository.addAddress(
          name: addressNameController.text,
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
        //Get.snackbar('Error', 'deneme');
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

  Future<void> deleteAddress(String id) async {
    _isLoading.value = true;
    try {
      update();
      final response = await addressesRepository.deleteAddress(id);
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

}