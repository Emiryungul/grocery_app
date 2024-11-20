import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/user_model.dart';
import '../repositories/FavoritesRepository.dart';
import '../utils/token_storage.dart';
import '../models/favorites_model.dart'as favorites;

class FavoritesController extends GetxController {
  final FavoritesRepository favoritesRepository;
  final TokenStorage tokenStorage = TokenStorage();

  FavoritesController({Key? key, required this.favoritesRepository});

  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _token = Rxn<String>();

  final Rxn<favorites.FavoritesModel> _favoritesValue =
  Rxn<favorites.FavoritesModel>();

  favorites.FavoritesModel? get favoritesValue => _favoritesValue.value;

  bool get isLoading => _isLoading.value;

  User? get user => _user.value;

  String? get token => _token.value;

  @override
  void onInit() {
    super.onInit();

  }




}