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
    print('HoangNH: ${controller.uniqueDevices.length}');
    super.initState();
  }
  String barcode = 'Tap  to scan';
  var color = "1".obs;
  final controller = Get.find<DiviceController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Scanner'),
      ),
      body: ListView.builder(
        itemCount: controller.uniqueDevices.length,
        itemBuilder: (context, index) {
          return Obx(() => Container(
            child:  Row(
              children: [
                Text(
                    'sasaSASAS${controller.uniqueDevices.value[index].title}'),
                Container(
                  height: 30,
                  width: 30,
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: Image.memory(
                        filterQuality: FilterQuality.high,
                        controller
                            .uniqueDevices.value[index].value),
                  ),
                )
              ],
            )
          ),);
        },
      )
    );
  }
}
