import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/core/utils/constants.dart';
import 'package:app_mobile_doan/presentation/attendance_screen/attendance_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AttendanceScreen extends GetWidget<AttendanceController>{
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Config');
    return Scaffold(
      appBar:AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: darkTextColor,),
        onPressed: () {
          Get.offAndToNamed(AppRoutes.homeScreen);
        },
      ),
      backgroundColor: Colors.white,
      title: Text(
          "Hệ thống điểm danh",
          style: AppStyle.titleTopPage,
        ),),
      body: Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.only(left: appPadding*5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text('Thời gian', style: AppStyle.txtContentCard.copyWith(color: darkTextColor)),
                            SizedBox(width: 10,),
                            Icon(
                                  Icons.edit_calendar_rounded,
                                  color: Colors.blue,
                                  size: 24.0,
                                  semanticLabel: 'Xem lịch',
                                ),
                            SizedBox(width: 10,),
                            Container(
                                width: 150,
                                child:DateTimePicker(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      type: DateTimePickerType.date,
                                      dateMask: 'dd-MM-yyyy',
                                      initialValue: DateTime.now().toString(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      icon: const Icon(Icons.event, size: 24),
                                      onChanged: (val) {
                                        
                                      },
                                      // validator: (val) {
                                      //   print(val);
                                      //   vmsController.runNameFilter(val!);
                                      //   return null;
                                      // },
                                    ),
                              )  
                            
                        ],
                      ),
                    ),
                    Obx(() => Text("Sỹ số lớp : ${controller.comat.value.toString()}/${homeController.siso.value.toString()}, Vắng ${homeController.siso.value-controller.comat.value}"),),
                    TextButton(
                        onPressed: () {
                          // controller.deleteAllDatabases();
                          Get.dialog(
                            Dialog(
                                child: Container(
                                  height: Get.height,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () => Get.back(),
                                            icon: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("Sinh viên vắng mặt",style: AppStyle.titleTopPage,),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child:Obx(() => controller.listStudentLeave.isNotEmpty
                                            ?ListView.builder(
                                              itemCount: controller.listStudentLeave.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: darkTextColor),
                                                    borderRadius: BorderRadius.circular(8.0)
                                                  ),
                                                  margin: EdgeInsets.all(appPadding),
                                                  padding: EdgeInsets.all(appPadding),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text("${controller.listStudentLeave.value[index].tenSV}",style: AppStyle.txtCartTitle,),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: 'Mã số sinh viên : ',
                                                                      style: AppStyle.txtContentCard
                                                                    ),
                                                                    TextSpan(
                                                                      text: '${controller.listStudentLeave.value[index].maSV}',
                                                                      style: AppStyle.txtContentCard.copyWith(color: blue)
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: 'Khoa : ',
                                                                      style: AppStyle.txtContentCard
                                                                    ),
                                                                    TextSpan(
                                                                      text: '${controller.listStudentLeave.value[index].khoa}',
                                                                      style: AppStyle.txtContentCard.copyWith(color: green)
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: 'Sđt : ',
                                                                      style: AppStyle.txtContentCard
                                                                    ),
                                                                    TextSpan(
                                                                      text: '${controller.listStudentLeave.value[index].soDT}',
                                                                      style: AppStyle.txtContentCard.copyWith(color: orange)
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                );
                                              },
                                            )
                                          :Center(child: Text('Không có dữ liệu'),))
                                      )
                                    ],
                                  ),
                                )
                              ),
                          );
                        },
                        child: Text("Bấm vào để xem chi tiết"))
                  ],
                )),
          ),
          Expanded(
            flex: 8,
            child:Obx(() =>controller.isGetdata.value
              ? controller.listEmployeeAttendance.isNotEmpty
              ?ListView.builder(
                itemCount: controller.listEmployeeAttendance.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: darkTextColor),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    margin: EdgeInsets.all(appPadding),
                    padding: EdgeInsets.all(appPadding),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              Get.dialog(Dialog(
                                child:Container(
                                  color: transparent,
                                  height: 400,
                                  width: 200,
                                  child: Transform.rotate(
                                    angle: pi/2,
                                    child:Image(
                                      image: FileImage(File('${controller.listEmployeeAttendance.value[index].image}')),
                                    ) ,
                                  ),
                                ) ,
                              ));
                            },
                            child: Container(
                                padding: EdgeInsets.all(appPadding),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.white, width: 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child:Obx(() => controller.listEmployeeAttendance.value[index].image != ''?
                                Container(
                                  height: 100,
                                  child: Transform.rotate(
                                    angle: pi/2,
                                    child:Image(
                                      image: FileImage(File('${controller.listEmployeeAttendance.value[index].image}')),
                                    ) ,
                                  ),
                                )
                                :Container(),)
                                ),
                              ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Text("${controller.listEmployeeAttendance.value[index].name}",style: AppStyle.txtCartTitle,),
                                 RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Mã số sinh viên : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${controller.listEmployeeAttendance.value[index].masv}',
                                        style: AppStyle.txtContentCard.copyWith(color: blue)
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Thời gian vào : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${controller.listEmployeeAttendance.value[index].timeIn}',
                                        style: AppStyle.txtContentCard.copyWith(color: green)
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() => controller.listEmployeeAttendance.value[index].timeIn.contains(controller.listEmployeeAttendance.value[index].timeOut)
                                ?RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Thời gian ra : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '-',
                                        style: AppStyle.txtContentCard.copyWith(color: red),
                                      )
                                    ],
                                  ),
                                ):RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Thời gian ra : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${controller.listEmployeeAttendance.value[index].timeOut}',
                                        style: AppStyle.txtContentCard.copyWith(color: red),
                                      ),
                                    ],
                                  ),
                                ),)
                            ],
                          ),
                        )
                      ],
                    )
                  );
                },
              )
            :Center(child: Text('Không có dữ liệu'),)
          :Center(child: CircularProgressIndicator(color: darkTextColor),))
          )
        ],
      ),
    ),
    );
  }
}
