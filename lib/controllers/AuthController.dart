import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/AuthRepository.dart';
import '../routes/app_names.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';
import 'CartController.dart';
import '../models/user_info_model.dart' as userInfo;
import 'FavoritesController.dart';
import '../models/add_user_address_model.dart' as address ;
import '../models/show_user_addresses_model.dart' as user_addresses;

class AuthorizationController extends GetxController {
  final AuthorizationRepository authorizationRepository;
  final TokenStorage tokenStorage = TokenStorage();

  AuthorizationController({Key? key, required this.authorizationRepository});



  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _token = Rxn<String>();
  var emailController = TextEditingController();
  var addressEmailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var addressNameController = TextEditingController();
  var addressInfoController = TextEditingController();
  var addressMarkerController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();
  var postCodeController = TextEditingController();

  final Rxn<userInfo.GetUserModel> _userInf =
  Rxn<userInfo.GetUserModel>();

  userInfo.GetUserModel? get userValue => _userInf.value;

  bool get isLoading => _isLoading.value;

  User? get user => _user.value;

  String? get token => _token.value;

  final Rxn<address.AddUserAddressModel> _address =
  Rxn<address.AddUserAddressModel>();

  address.AddUserAddressModel? get addressValue => _address.value;

  final Rxn<user_addresses.ShowUserAddressesModel> _userAddresses =
  Rxn<user_addresses.ShowUserAddressesModel>();

  user_addresses.ShowUserAddressesModel? get userAddress => _userAddresses.value;

  @override
  void onInit() {
    super.onInit();
    everAll([_token], _redirectBasedOnAuthStatus);
    _checkAuthenticationStatus();

  }

  Future<void> authenticate() async {
    _isLoading.value = true;
    try {
      final response = await authorizationRepository.login(
          emailController.text, passwordController.text);
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = response.body;
        final authorizationModel = userModelFromJson(responseBody);
        // Update the user and token in the controller
        _user.value = authorizationModel.user;
        debugPrint(responseBody);
          if (authorizationModel.token!= null) {
            await tokenStorage.saveToken(authorizationModel.token!);
            _token.value = authorizationModel.token;
            debugPrint("TOKEN: ${_token.value}");
            Get.back();
            Get.snackbar('Başarılı', "${_user.value?.email}"' Hesabınıza Giriş Yaptınız');
          }
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        Get.snackbar('Dikkat !', "Bu Bilgiler Sistemimizde Bulunmamakta");
      }
    } catch (e) {
      Get.snackbar('Hata', 'Lütfen bilgilerinizi kontrol ediniz');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> register() async {
    _isLoading.value = true;
    try {
      final response = await authorizationRepository.register(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        rePassword: confirmPasswordController.text
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response body
        final responseBody = response.body;
        final encodedBody = jsonDecode(responseBody);
        /*if (encodedBody["success"] == true) {
          if (encodedBody['email_verify'] == true) {
            showCupertinoDialog(
              context: Get.context!,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Verification'),
                content: Text(
                    'Onaylama Linki Şu Adrese Yollanmıştır ${emailController.text}.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _isLoading.value = false;
                    },
                  ),
                ],
              ),
            );
            return;
          }
        }*/
        final authorizationModel = userModelFromJson(responseBody);
        // Update the user and token in the controller
        _user.value = authorizationModel.user;
        if (authorizationModel.token != null) {
          await tokenStorage.saveToken(authorizationModel.token!);
          _token.value = authorizationModel.token;
          debugPrint("TOKEN: ${_token.value}");
          Get.offAllNamed(AppRoutes.navBarScreen);
          Get.snackbar('Kayıt Oldunuz !', 'Başarılı Bir Şekilde Kayıt oldunuz!');
        }
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        //Get.snackbar('Error', error);
      }
    } catch (e) {
      Get.snackbar('Error', 'register ${e}');
    } finally {
      update();
      _isLoading.value = false;
    }
  }

  Future<void> newAddress() async {
    _isLoading.value = true;
    try {
      update();
      final response = await authorizationRepository.addAddress(
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
      final response = await authorizationRepository.fetchAddresses();
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

  Future<void> getUser() async {
    _isLoading.value = true;
    try {
      final response = await authorizationRepository.user();
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = response.body;
        final authorizationModel = userInfo.getUserModelFromJson(responseBody);
        // Update the user in the controller
        _userInf.value = authorizationModel;
        //print(_user.value?.name);
        //print(_user.value?.email);
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        //Get.snackbar('Error', error);
      }
    } catch (e) {
      //Get.snackbar('Error', '${e}');
    } finally {
      update();
      _isLoading.value = false;
    }
  }
  Future<void> logOut() async {
    //firebaseApi.unSubscribeFromNotificationTopics();
    await tokenStorage.deleteToken();
    _token.value = null;
    _user.value = null;
    Get.snackbar('Çıkış', 'Hesaptan Çıkış Yapıldı');
    update();
  }

  Future<void> _checkAuthenticationStatus() async {
    final token = await tokenStorage.getToken();
    if (token != null) {
      // Token exists, update the token
      _token.value = token;
    }
  }

  void _redirectBasedOnAuthStatus(dynamic _) async{
    if (_token.value != null) {
      // User is authenticated
      debugPrint("Redirecting");
      print(_token.value);
      Get.find<CartController>().fetchCartItems();
      Get.find<FavoritesController>().fetchFavoriteItems();
      getUser();
    } else {
      // User is not authenticated
    }
  }
}