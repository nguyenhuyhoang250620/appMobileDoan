import 'package:app_mobile_doan/presentation/home_screen/models/home_model.dart';
import 'package:app_mobile_doan/presentation/login_screen/controller/login_controller.dart';
import 'package:multiselect/multiselect.dart';

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
                Container(
                  height: 60,
                  color: darkTextColor.withOpacity(0.2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: appPadding),
                          child: Obx(
                            () => Text(
                              "Hii, ${controller.MaGV.value} 👋",
                              style: AppStyle.titleTop,
                            ),
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            loginController.logout();
                          },
                        ),
                      )
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
                Center(child: Text('Lựa chọn mã học phần')),
                Expanded(
                    flex: 1,
                    child: Obx(
                      () => controller.danh_sach_mon.value.isNotEmpty
                          ? Container(
                              height: Get.height,
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: appPadding, vertical: appPadding),
                              child: DropdownButtonFormField(
                                elevation: 4,

                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(appPadding),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: darkTextColor, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                isExpanded: true,
                                // hint: const Text(
                                //   'Select Your Gender',
                                //   style: TextStyle(fontSize: 14),
                                // ),
                                icon: const Icon(
                                  Icons.class_,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                value: controller.danh_sach_mon.value[0],
                                items: controller.danh_sach_mon.value
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                              style: AppStyle.titleTopPage),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'lbl_please_choose_time'.tr;
                                  }
                                },
                                onChanged: (value) {
                                  controller.attendanceDocument(
                                      controller.MaGV.value, value.toString());
                                },
                                onSaved: (value) {
                                  //selectedValue = value.toString();
                                },
                              ),
                            )
                          : Container(),
                    )),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: Get.height,
                    width: Get.width,
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
                          return InkWell(
                            onTap: () {
                              if (index == 0) {}
                              if (index == 1) {
                                Get.offAndToNamed(AppRoutes.diviceScreen);
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Get.offAndToNamed(AppRoutes.attendanceScreen);
                                } else if (index == 1) {
                                  Get.offAndToNamed(AppRoutes.studenManagement);
                                } else if (index == 2) {
                                  Get.offAndToNamed(AppRoutes.chartsScreen);
                                } else if (index == 3) {
                                  Get.offAndToNamed(AppRoutes.calendarEvent);
                                } else if (index == 4) {
                                  Get.offAndToNamed(AppRoutes.diviceScreen);
                                } else {
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
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
