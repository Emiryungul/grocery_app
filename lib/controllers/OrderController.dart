import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/user_model.dart';
import '../repositories/OrderRepository.dart';
import '../utils/http_error_handler.dart';
import '../utils/token_storage.dart';
import '../models/order_history_items_model.dart' as order;

class OrderController extends GetxController {
  final OrderRepository orderRepository;
  final TokenStorage tokenStorage = TokenStorage();

  OrderController({Key? key, required this.orderRepository});

  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _token = Rxn<String>();

   bool get isLoading => _isLoading.value;

  User? get user => _user.value;

  String? get token => _token.value;

  final Rxn<order.OrderHistoryItemsModel> _orderItem =
  Rxn<order.OrderHistoryItemsModel>();

  order.OrderHistoryItemsModel? get orderItem =>
      _orderItem.value;

  @override
  void onInit() {
    super.onInit();
    fetchOrderItems();
  }

  Future<void> fetchOrderItems() async {
    _isLoading.value = true;
    try {
      final response = await orderRepository.fetchOrderItems();
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        // Parse the response body
        final responseBody = response.body;
        final orderModel = order.orderHistoryItemsModelFromJson(responseBody);
        _orderItem.value = orderModel;

        // debugPrint(responseBody);
        //print("*****************");
        //print(favoritesValue?.toJson());
      } else {
        // Handle different status codes
        final error = HttpErrorHandler.handle(response.statusCode);
        //Get.snackbar('Error', error);
      }
    } catch (e) {
      //Get.snackbar('Error', "$e");
      print("$e");
    } finally {
      _isLoading.value = false;
      update();
    }
  }



}