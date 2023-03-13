
import 'package:app_mobile_doan/presentation/attendance_screen/attendance_binding.dart';
import 'package:app_mobile_doan/presentation/attendance_screen/attendance_screen.dart';
import 'package:app_mobile_doan/presentation/divice_screen/binding/divice_binding.dart';
import 'package:app_mobile_doan/presentation/divice_screen/divice_screen.dart';
import 'package:app_mobile_doan/presentation/home_screen/home_screen.dart';
import 'package:app_mobile_doan/presentation/home_screen/binding/home_binding.dart';
import 'package:app_mobile_doan/presentation/studen_management/studen_binding.dart';
import 'package:app_mobile_doan/presentation/studen_management/studen_management.dart';
import 'package:get/get.dart';
import 'package:app_mobile_doan/presentation/login_screen/binding/login_binding.dart';
import 'package:app_mobile_doan/presentation/login_screen/login_screen.dart';

class AppRoutes {
  static String loginScreen = '/login_screen';

  static String homeScreen = '/home_screen';

  static String diviceScreen = '/divice_screen';

  static String initialRoute = '/home_screen';

  static String attendanceScreen = '/attendance_screen';

  static String studenManagement = '/studen_management';

  static List<GetPage> pages = [
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: diviceScreen,
      page: () => DiviceScreen(),
      bindings: [
        DiviceBinding(),
      ],
    ),
    GetPage(
      name: attendanceScreen,
      page: () => AttendanceScreen(),
      bindings: [
        AttendanceBinding(),
      ],
    ),
     GetPage(
      name: studenManagement,
      page: () => StudenManagement(),
      bindings: [
        StudenBinding(),
      ],
    ),
  ];
}
