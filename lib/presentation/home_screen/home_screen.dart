import 'package:app_mobile_doan/presentation/home_screen/models/home_model.dart';
import 'package:app_mobile_doan/presentation/login_screen/controller/login_controller.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:multiselect/multiselect.dart';

import '../../core/utils/constants.dart';
import '../../widgets/custom_button_alert.dart';
import 'controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile_doan/core/app_export.dart';

import 'models/data.dart';

class HomeScreen extends GetWidget<HomeController> {
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstant.whiteA700,
          body: Container(
            height: Get.height,
            width: Get.width,
            color: bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  color:  darkTextColor.withOpacity(0.6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed(AppRoutes.generalScreen), 
                        icon: Icon(Icons.arrow_back,color: bgColor,)
                      ),
                      Text("Hệ thống điểm danh",style: AppStyle.titleTop.copyWith(color: bgColor),)
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: darkTextColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Giảng viên vui lòng ấn để Check-In',style: AppStyle.txtRobotoRegular16.copyWith(color: darkTextColor),),
                      IconButton(
                        onPressed: () {
                          controller.CheckInTeacher();
                          Get.dialog(AlertDialog(
                            content: Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(child: Text("Điểm danh thành công")),
                            ),
                          ));
                          Future.delayed(const Duration(seconds: 2), () {
                              Get.back();
                          });
                        }, 
                        icon: Icon(Icons.check_circle_outline_outlined),
                        iconSize: 30,
                        color: blue,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 1),
                    color: bgColor,
                    child: GridView.count(
                      primary: false,
                      // padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        ...List.generate(modelList.length, (index) {
                          HomeModel model = modelList[index];
                          return  InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Get.toNamed(AppRoutes.attendanceScreen);
                                } else if (index == 1) {
                                  Get.toNamed(AppRoutes.studenManagement);
                                } else if (index == 2) {
                                  Get.toNamed(AppRoutes.chartsScreen);
                                } else if (index == 3) {
                                  Get.toNamed(AppRoutes.calendarEvent);
                                } else if (index == 4) {
                                  Get.offAllNamed(AppRoutes.diviceScreen);
                                } else {
                                  Get.toNamed(AppRoutes.chatGroup);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.all(appPadding),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: bgColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: darkTextColor,
                                      blurRadius:
                                          2.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          2.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        0.0, // horizontal, move right 10
                                        2.0, // vertical, move down 10
                                      ),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: model.color),
                                          child: model.icon,
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${model.title}',
                                          style: AppStyle.txtContentCard,
                                        )),
                                    Divider(
                                      color: textColor,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text("${model.content}",
                                          style: AppStyle.txtInterRegular14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        })
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("© NHH GROUP 2023. All rights reserved")),
                )
              ],
            ),
          ),),
    );
  }
}
