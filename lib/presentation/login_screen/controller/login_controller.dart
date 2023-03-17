import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/app_export.dart';

class LoginController extends GetxController {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController emailControllerForgot = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  var obscureText = true.obs;
  var isAdmin = "tennguoidungoccho@gmail.com".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('MaGV', email);
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${email}@gmail.com',
        password: password,
      ).then((value){
        print('HoangNH: $value');
        return value;
      });
      Get.offAndToNamed(AppRoutes.homeScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('MaGV'); 
  await FirebaseAuth.instance.signOut(); 
  Get.offAndToNamed(AppRoutes.loginScreen);
}

}

void forgetPassword(String email) {}
