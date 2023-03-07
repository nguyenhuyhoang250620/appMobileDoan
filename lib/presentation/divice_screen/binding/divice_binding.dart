import '../controller/divice_controller.dart';
import 'package:get/get.dart';

class DiviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiviceController());
  }
}
