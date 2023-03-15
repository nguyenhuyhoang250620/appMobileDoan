import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/calendar_event/calendar_controller.dart';

class CalendarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarController());
  }

}