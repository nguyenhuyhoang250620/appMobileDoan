import 'package:app_mobile_doan/presentation/divice_screen/controller/divice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

import '../../core/app_export.dart';
import '../../core/utils/constants.dart';

class StudenManagement extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StudenState();
  }

}
class StudenState extends State<StudenManagement>{
  final controller = Get.find<DiviceController>();
  @override
  void initState() {
    print('HoangNH: ${controller.uniqueDevices.length}');
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropDownMultiSelect(
                  icon: Icon(Icons.search),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                  ),
                  onChanged: (p0) {
                    print(p0);
                  },
                  enabled: true,
                  //TungVD: list location camera init from server with isMonitoring = true
                  options: ["1", "2"],
                  //TungVD: list item selected filter from allvmslocationlist
                  selectedValues: [],
                  whenEmpty: 'Tìm kiếm sinh viên',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Obx(() => ListView.builder(
              itemCount: controller.uniqueDevices.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.people,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Họ tên : ${controller.uniqueDevices[index].title}"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),)
          )
        ],
      ),
    ),
    );
  }
}
