import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controllers/AuthController.dart';
import '../../utils/app_colors.dart';
import '../widgets/appbutton_widget.dart';
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _isObscured = true;
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen email adresinizi giriniz ';
    }
    // Use a regular expression for basic email format validation
    // This is a simple example and might not cover all edge cases
    final emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'lütfen geçerli bir email adresi giriniz ';
    }

    return null;
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthorizationController>(builder: (controller)
    {
      return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_outlined),
                        //hintText: 'email',
                        labelText: 'email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: controller.passwordController,
                      obscureText:
                      _isObscured, // Set this to true to obscure text
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isObscured
                                  ? AppColors.greyShipColor
                                  : AppColors
                                  .greyShipColor, // Change icon color
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscured =
                                !_isObscured; // Toggle obscureText value
                              });
                            },
                          ),
                          labelText: 'Şifre',
                          labelStyle: TextStyle(fontWeight: FontWeight.w400),
                          //hintText: 'Şifre',
                          border: OutlineInputBorder()),
                      validator: (email) =>
                      email!.isEmpty ? 'Lütfen şifre giriniz' : null),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.authenticate();

                        // Clear the text fields after authentication
                        controller.emailController.clear();
                        controller.passwordController.clear();
                      }
                    },
                    child: AppButton(
                        color: AppColors.turquoiseColor,
                        text: "Giriş Yapın"
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
