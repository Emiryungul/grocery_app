import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/OrderController.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.greyShipColor,
          title: Text("Orders", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
                orderController.orderItem?.orders?.length ?? 0, (index) {
              var product = orderController.orderItem?.orders?[index];
              var product2 = product?.items?[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100.w,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 10, top: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    "${product2?.product?.imageUrl}",
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("${product2?.product?.name}"),
                                      Text("Order Status: ${product?.status}"),
                                      Text("Quantity: ${product2?.quantity}"),
                                      Text(
                                        "Order Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(product2?.updatedAt ?? ''))}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
