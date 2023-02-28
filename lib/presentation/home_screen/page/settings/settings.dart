import 'dart:math';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingManagement extends StatefulWidget {
  const SettingManagement({Key? key}) : super(key: key);

  @override
  State<SettingManagement> createState() => _SettingState();
}

class _SettingState extends State<SettingManagement> {
  String barcode = 'Tap  to scan';
  var color = "1".obs;
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Scanner'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: Obx(
                  () => controller.test.value
                      ? AiBarcodeScanner(
                          validateText: '',
                          onScannerStarted: (p0) {
                            print("dasdsadddddddddddddddddddddddddddddd");
                          }, // link to be validated
                          validateType: ValidateType.contains,
                          // canPop: true,
                          // allowDuplicates: true,
                          errorColor: Colors.red,
                          successColor:controller.test1.value? Colors.red:Colors.green,

                          onScan: (String value) {
                            debugPrint(value);
                            barcode = value;
                            color.value = "2";
                            controller.test1.value = false;
                            Future.delayed(Duration(milliseconds: 2500), () {
                              controller.test1.value = true;
                            });
                            
                          },
                          onDetect: (p0) {
                            controller.image = p0.image;
                          },
                          controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates,
                            autoStart: true,
                            facing: CameraFacing.back,
                            returnImage: true,
                          ),
                          borderColor: Colors.red,
                        )
                      : Container(
                          height: 300,
                          width: 500,
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Image.memory(
                                filterQuality: FilterQuality.high,
                                controller.image!),
                          ),
                        ),
                )),
            Expanded(flex: 1, child: Obx(() => Text('${color.value}'))),
          ],
        ),
      ),
    );
  }
}
