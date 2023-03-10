import 'dart:math';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../divice_screen/controller/divice_controller.dart';

class SettingManagement extends StatefulWidget {
  const SettingManagement({Key? key}) : super(key: key);

  @override
  State<SettingManagement> createState() => _SettingState();
}

class _SettingState extends State<SettingManagement> {
  @override
  void initState() {
    super.initState();
  }
  List<dynamic> test = [
    {
       "sv":[
        {
            "ten":"hoang"
        }
       ],
       "phong":{
            "tenphong":"phonga"
       },
       "mon":{
            "tenmon":"tenmon"
       },
       "thoigian":{
            "tenca":"tenca"
       },
       "giangvien":{
            "tengv":"tengv"
       },
       "phongban":{
            "tenphong":"tenphong"
       }
    }
];
final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Scannsser'),
      ),
      body: ListView.builder(
        itemCount: test.length,
        itemBuilder: (context, index) {
            var sv = test[index]["sv"];
            var phong = test[index]["phong"]['tenphong'];
            var mon = test[index]["mon"]['tenmon'];
            var thoigian = test[index]["thoigian"]['tenca'];
            var giangvien = test[index]["giangvien"]['tengv'];
            var phongban = test[index]["phongban"]['tenphong'];
          return Column(
            children: [
              Text("Tên phòng1: $sv"),
              SizedBox(height: 20,),
              Text("Tên phòng2: $phong"),
              SizedBox(height: 20,),
              Text("Tên phòng3: $mon"),
              SizedBox(height: 20,),
              Text("Tên phòng4: $thoigian"),
              SizedBox(height: 20,),
              Text("Tên phòng4: $giangvien"),
              SizedBox(height: 20,),
              Text("Tên phòng4: $phongban"),
              TextButton(onPressed: () {
                controller.addData();
              }, child: Text("cliock"))
            ],
          );
        },
      )
    );
  }
}
