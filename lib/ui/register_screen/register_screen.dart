import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/controllers/AuthController.dart';

import '../../utils/app_colors.dart';
import '../widgets/appbutton_widget.dart';

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _isObscured = true;
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
    return GetBuilder<AuthorizationController>(
      builder: (authController) {

        String? confirmPasswordValidator(String? value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          } else if (value != authController.passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.turquoiseColor,
            elevation: 1,
            centerTitle: true ,
            title: Text("Register"),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.turquoiseColor, // Purple
                  AppColors.scaffoldBackgroundColor, // Red
                  AppColors.whiteAppColor, // Orange
                ],
              ),
            ),
            child: Form(
              key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100,),
                      child: Text("GastroHub",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70,),
                      child: Text("Your 4 Textforms away from perfection !!",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25,left: 25),
                      child: TextFormField(
                        controller: authController.nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_2_outlined),
                            //hintText: 'email',
                            labelText: 'name',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder()),
                        validator: (email) =>
                        email!.isEmpty ? 'Please enter a name' : null,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(right: 25,left: 25),
                      child: TextFormField(
                        controller: authController.emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email_outlined),
                            //hintText: 'email',
                            labelText: 'email',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25,left: 25),
                      child: TextFormField(
                          controller: authController.passwordController,
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
                              labelText: 'password',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400),
                              //hintText: 'Şifre',
                              border: OutlineInputBorder()),
                          validator: (email) =>
                          email!.isEmpty ? 'Please enter password' : null),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(right: 25,left: 25),
                      child: TextFormField(
                          controller: authController.confirmPasswordController,
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
                              labelText: 'rePassword',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400),
                              //hintText: 'Şifre',
                              border: OutlineInputBorder()),
                          validator: confirmPasswordValidator),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            authController.register();
                            // Clear the text fields after authentication
                            authController.emailController.clear();
                            authController.passwordController.clear();
                            authController.nameController.clear();
                            authController.confirmPasswordController.clear();
                          }
                        },
                        child: AppButton(
                            color: AppColors.turquoiseColor,
                            text: "Register"
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        );
      }
    );
  }
}
