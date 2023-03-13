import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/studen_management/studen_controller.dart';

import '../divice_screen/controller/divice_controller.dart';

class StudenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StudenController());
    Get.lazyPut(() => DiviceController());
  }

}