import 'package:app_mobile_doan/presentation/divice_screen/controller/divice_controller.dart';
import 'package:app_mobile_doan/presentation/login_screen/controller/login_controller.dart';

import '../controller/general_controller.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GeneralController());
    Get.lazyPut(() => DiviceController());
    Get.lazyPut(() => LoginController());
  }
}
