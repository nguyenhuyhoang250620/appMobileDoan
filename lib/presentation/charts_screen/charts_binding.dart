import 'package:app_mobile_doan/core/app_export.dart';

import 'charts_controller.dart';

class ChartsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChartsController());
  }

}