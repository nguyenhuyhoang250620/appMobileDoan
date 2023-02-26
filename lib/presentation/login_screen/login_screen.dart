import 'controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile_doan/core/app_export.dart';

class LoginScreen extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input!.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              onSaved: (input) => controller.emailController.text = input!,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              validator: (input) {
                if (input!.length < 6) {
                  return 'Your password needs to be at least 6 characters';
                }
                return null;
              },
              onSaved: (input) => controller.passwordController.text = input!,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.formKey.currentState!.save();
                  // Authenticate with backend and handle login logic here
                  Get.offAndToNamed(AppRoutes.homeScreen);
                }
              },
              child: Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
