import 'package:app_mobile_doan/presentation/home_screen/models/home_model.dart';
import 'package:app_mobile_doan/presentation/login_screen/controller/login_controller.dart';
import 'package:app_mobile_doan/widgets/custom_button.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/constants.dart';
import '../../widgets/custom_button_alert.dart';
import 'controller/general_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile_doan/core/app_export.dart';



class GeneralScreen extends GetWidget<GeneralController> {
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Scaffold(
          backgroundColor: bgColor,
          body: Column(
            children: [
              Container(
                  height: 60,
                  color: darkTextColor.withOpacity(0.6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: appPadding),
                          child: Text(
                              "Xin chào 👋, ${controller.MaGV.value}",
                              style: AppStyle.titleTop.copyWith(color: bgColor),
                            ),),
                    ],
                  ),
                ),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: Card(
                  elevation: 6,
                  child: Container(
                    height: 70,
                    width: Get.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(appPadding),
                    child: Text("Danh sách lớp học phần",style: AppStyle.titleTop,),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  padding: EdgeInsets.all(appPadding),
                  child: Obx(() => controller.danh_sach_mon.isNotEmpty?
                    ListView.builder(
                      itemCount: controller.danh_sach_mon.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 60,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: darkTextColor),
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            margin: EdgeInsets.all(appPadding),
                            padding: EdgeInsets.all(appPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('  ☛ ${controller.danh_sach_mon[index].TenHocPhan}'),
                                IconButton(
                                  onPressed:() async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('MaHocPhan',controller.danh_sach_mon[index].MaHocPhan!);
                                    Get.offAllNamed(AppRoutes.homeScreen);
                                  },
                                  icon: Icon(Icons.camera_enhance),
                                  )
                              ],
                            ),
                          );
                      },
                    ):Center(child: CircularProgressIndicator(color: darkTextColor),),),
                ),
              )
            ],
          ),
        floatingActionButton: InkWell(
          onTap: () => loginController.logout(),
          child: Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: darkTextColor
            ),
            child: Center(
              child: Icon(Icons.logout,color: bgColor,),
            ),
          ),
        ),    
      ),
    );
  }
}

