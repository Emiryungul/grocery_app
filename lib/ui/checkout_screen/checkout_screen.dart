import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AddressesController.dart';
import 'package:grocery_app/controllers/CartController.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/ui/widgets/appbutton_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_colors.dart';
import '../widgets/boxshadow_widget.dart';

final _formKey = GlobalKey<FormState>();

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          GetBuilder<AddressesController>(builder: (addressController) {
        return GetBuilder<CartController>(builder: (cartController) {
          return BottomAppBar(
            color: Colors.white,
            elevation: 1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Text(
                        "Sum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${cartController.cartValue?.meta?.totalPrice}\$",
                        style: TextStyle(
                            color: AppColors.blueTiffany, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: cartController.isPayForTheCartLoading.value
                      ? null // Disable the button when loading
                      : () {
                          if (addressController.selectedAddress.value == null) {
                            // If the address is not selected, show the address selection message.
                            Get.snackbar("Please Choose A Address",
                                "Please Choose A Address");
                          } else if (!_formKey.currentState!.validate()) {
                            // If the form is not valid, show the card information message.
                            Get.snackbar("Please Enter Card Information's",
                                "Please Enter Card Information's");
                          } else {
                            // If both conditions are met, proceed with the payment.
                            cartController.payForTheCart(
                              addressId:
                                  "${addressController.selectedAddress.value?.id}",
                            );
                          }
                        },
                  child: Container(
                    width: 60.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: AppColors.blueTiffany,
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                        child: Text(
                      "Pay Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          );
        });
      }),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "Choose Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 30.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueTiffany,
                            borderRadius: BorderRadius.circular(35)),
                        child: Center(
                            child: Text(
                          "Add Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<AddressesController>(builder: (controller) {
                    return Column(
                        children: List.generate(
                            controller.userAddress?.addresses?.length ?? 0,
                            (index) {
                      var product = controller.userAddress?.addresses?[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            controller.updateSelectedAddress(product);
                          },
                          child: Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: controller.selectedAddress.value == product
                                  ? AppColors.blueLightCambridge
                                  : AppColors.whiteAppColor,
                              boxShadow: [BoxShadowWidget.light],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(Icons.location_on_outlined),
                                  ),
                                  Flexible(
                                    child: Text("${product?.address}",
                                        style: TextStyle(fontSize: 16),
                                        overflow: TextOverflow.visible,
                                        maxLines: 2),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller
                                              .deleteAddress("${product?.id}");
                                          controller.fetchAddresses();
                                        },
                                        child: Icon(Icons.delete_outline)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
                  }),
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
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                                      final googleMapsUrl =
                                          'https://www.google.com/maps/search/?api=1&query=${addressController.selectedAddress.value?.lat},${addressController.selectedAddress.value?.lon}';
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
                                SizedBox(
                                  width: 12,
                                ),
                                GetBuilder<AddressesController>(
                                  builder: (addressesController) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          addressController.selectedAddress.value == null
                                              ? "" // Display blank text
                                              : "${product?.name}",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          addressController.selectedAddress.value == null
                                              ? "" // Display blank text
                                              :
                                          "${product?.address}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          addressController.selectedAddress.value == null
                                              ? "" // Display blank text
                                              :
                                          "${product?.marker}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    );
                                  }
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
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
                          Text(
                            "Order Summary",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
                                Text("${product?.quantity}" "x "),
                                Text(
                                  "${product?.name}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                              Text(
                                "Sum",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                    "${cartController.cartValue?.meta?.totalPrice}\$"),
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
                /*Padding(
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
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Card(
                    color: AppColors.whiteAppColor,
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Debit Card Payment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  inputFormatters: [UpperCaseTextFormatter()],
                                  controller:
                                      cartController.cardHolderNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name & Surname',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(16),
                                  ],
                                  controller:
                                      cartController.cardNumberController,
                                  decoration: InputDecoration(
                                    labelText: 'Card Number',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Card Number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          ExpiryDateInputFormatter(),
                                        ],
                                        controller: cartController
                                            .cardExpiryDateController,
                                        decoration: InputDecoration(
                                          labelText: 'Expiry Date',
                                          labelStyle: TextStyle(
                                              color: Colors.grey[700]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Expiry Date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(3),
                                        ],
                                        controller:
                                            cartController.cardCVVController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'CVV',
                                          labelStyle: TextStyle(
                                              color: Colors.grey[700]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter CVV';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.length == 1 &&
        int.tryParse(text[0]) != null &&
        int.parse(text[0]) > 1) {
      // Prevent invalid month input (e.g., 4 is allowed but 5 is not)
      text = '0$text';
    } else if (text.length == 2 && oldValue.text.length == 1) {
      text += '/';
    } else if (text.length > 2 && text[2] != '/') {
      text = text.substring(0, 2) + '/' + text.substring(2);
    } else if (text.length > 5) {
      text = text.substring(0, 5);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CreditCardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all existing spaces
    String text = newValue.text.replaceAll(' ', '');

    // Format text by grouping every 4 digits
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i != 0 && i % 4 == 0) {
        buffer.write(' '); // Insert space after every 4 digits
      }
      buffer.write(text[i]);
    }

    // Formatted text with spaces
    final String formattedText = buffer.toString();

    // Keep the cursor at the end of the text input
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Convert the input text to uppercase
    String upperCaseText = newValue.text.toUpperCase();

    // Maintain cursor position at the end
    return TextEditingValue(
      text: upperCaseText,
      selection: TextSelection.collapsed(offset: upperCaseText.length),
    );
  }
}
