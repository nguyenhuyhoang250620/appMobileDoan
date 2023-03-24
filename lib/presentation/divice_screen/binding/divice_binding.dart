import 'package:app_mobile_doan/presentation/general_screen/controller/general_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';

import '../controller/divice_controller.dart';
import 'package:get/get.dart';

class DiviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiviceController());
    Get.lazyPut(() => GeneralController());
  }
}
