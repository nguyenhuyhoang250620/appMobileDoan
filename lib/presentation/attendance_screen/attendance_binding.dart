import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/attendance_screen/attendance_controller.dart';

class AttendanceBinding extends Bindings{
    @override
    void dependencies() {
      Get.lazyPut(() => AttendanceController());
    }
}