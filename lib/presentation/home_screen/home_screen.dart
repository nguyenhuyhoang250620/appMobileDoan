import 'package:app_mobile_doan/presentation/home_screen/models/home_model.dart';
import 'package:app_mobile_doan/presentation/home_screen/page/scanner_management/scanner_management_screen.dart';
import 'package:app_mobile_doan/presentation/home_screen/page/settings/settings.dart';
import 'package:app_mobile_doan/presentation/home_screen/page/system_management/system_management.dart';
import 'package:app_mobile_doan/presentation/login_screen/controller/login_controller.dart';

import '../../core/utils/constants.dart';
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
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: appPadding),
                        child: Text("Hii,Văn Tiến 👋",style: AppStyle.titleTop,),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.power_settings_new_outlined),
                          onPressed: () {
                            loginController.logout();
                          },
                        ),
                      )
                    ],
                  )
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    padding: EdgeInsets.only(top: appPadding*2),
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
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                              }
                              if (index == 1) {
                                Get.offAndToNamed(AppRoutes.diviceScreen);
                              }
                            },
                            child: InkWell(
                              onTap:() {
                                if(index == 0){
                                  Get.offAndToNamed(AppRoutes.attendanceScreen);
                                }
                                else if(index == 1){
                                  Get.offAndToNamed(AppRoutes.studenManagement);
                                }
                                else if(index == 2){
                                  Get.offAndToNamed(AppRoutes.chartsScreen);
                                }
                                else if(index == 3){
                                  Get.offAndToNamed(AppRoutes.calendarEvent);
                                }
                                else if(index == 4){
                                  Get.offAndToNamed(AppRoutes.diviceScreen);
                                }
                                else{
                                  print('HoangNH: logout');
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
                                          blurRadius: 2.0, // has the effect of softening the shadow
                                          spreadRadius: 2.0, // has the effect of extending the shadow
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
                                    Expanded(flex: 6,child: Container(
                                      height: 80,
                                      width: 80,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: model.color
                                      ),
                                      child: model.icon,
                                    )),
                                    Expanded(flex: 2,child: Text('${model.title}',style: AppStyle.txtContentCard,)),
                                    Divider(color: textColor,),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                            "${model.content}",
                                            style: AppStyle.txtInterRegular14
                                          ),
                                    ),
                                  ],
                                ),
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
                  child: Center(
                    child: Text("Attendance Version 1.0 @release by Splendor"),
                  ),
                )
              ],
            ),
          )
          ),
    );
  }
}
