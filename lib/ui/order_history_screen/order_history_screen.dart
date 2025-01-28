import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/OrderController.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        return Scaffold(
          body: SingleChildScrollView(
            child:Column(
              children: List.generate(orderController.orderItem?.orders?.length ?? 0,
                  (index){
                var product =  orderController.orderItem?.orders?[index];
                var product2 =  orderController.orderItem?.orders?[index].items?[index];
                return Container(
                  child: Column(
                    children: [
                      Text("${product?.createdAt}"),
                    ],
                  )
                );
                  }),
            ),
          ),
        );
      }
    );
  }
}
