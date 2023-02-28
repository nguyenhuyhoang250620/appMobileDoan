import 'package:app_mobile_doan/presentation/home_screen/page/attendance%20management/attendance_management_screen.dart';
import 'package:app_mobile_doan/presentation/home_screen/page/scanner_management/scanner_management_screen.dart';
import 'package:app_mobile_doan/presentation/home_screen/page/settings/settings.dart';
import 'package:app_mobile_doan/presentation/home_screen/page/system_management/system_management.dart';

import 'controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile_doan/core/app_export.dart';

class HomeScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstant.whiteA700,
          body: Obx(() {
            if (controller.selectedIndex.value == 0) {
              return ScannerScreen(
                homeController: controller,
              );
            } else if (controller.selectedIndex.value == 1) {
              return AttendanceScreen();
            } else if (controller.selectedIndex.value == 2) {
              return SystemScreen(
                controller: controller,
              );
            }
            return SettingManagement();
          }),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.article_outlined),
                    label: 'Attendance',
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Class',
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Setting',
                    backgroundColor: Colors.black)
              ],
              currentIndex: controller.selectedIndex.value,
              selectedItemColor: Colors.amber[800],
              onTap: (e) {
                controller.selectedIndex.value = e;
              },
            ),
          )),
    );
  }
}
