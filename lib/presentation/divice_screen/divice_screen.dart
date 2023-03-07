import 'dart:math';
import 'dart:typed_data';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/divice_screen/controller/divice_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import 'models/divice_model.dart';

class DiviceScreen extends StatefulWidget {
  const DiviceScreen({Key? key}) : super(key: key);

  @override
  State<DiviceScreen> createState() => _DiviceState();
}

class _DiviceState extends State<DiviceScreen> {
  String barcode = 'Tap  to scan';
  var color = "1".obs;
  final controller = Get.find<DiviceController>();
  final List<String> listnua = [];
  final List<Uint8List> listnuahay = [];
  final List<DeviceModel> landau = [];
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
                flex: 5,
                child: Obx(() => controller.test.value == true
                        ? AiBarcodeScanner(
                            validateText: '',
                            onScannerStarted: (p0) {
                              print("dasdsadddddddddddddddddddddddddddddd");
                            }, // link to be validated
                            validateType: ValidateType.contains,
                            // canPop: true,
                            // allowDuplicates: true,
                            errorColor: Colors.red,
                            successColor: controller.test1.value
                                ? Colors.red
                                : Colors.green,

                            onScan: (String value) {
                              debugPrint(value);
                              controller.MaSV.value = value;
                              // listnua.add(value);
                              // controller.listtest.value =
                              //     listnua.toSet().toList();
                              // barcode = value;
                              // color.value = "2";
                              // controller.test1.value = false;

                              // Future.delayed(Duration(milliseconds: 2500), () {
                              //   controller.test1.value = true;
                              // });
                            },
                            onDetect: (p0) {
                              if(controller.MaSV.isNotEmpty){
                                controller.image = p0.image;
                              DeviceModel model = DeviceModel(
                                  title: controller.MaSV.value,
                                  value: controller.image!);
                              controller.lancuoi.value.add(model);
                              List<DeviceModel> devices =
                                  controller.lancuoi.value;
                              controller.uniqueDevices.value = devices
                                  .where((device) => device.title != null)
                                  .toSet()
                                  .toList();
                              }
                            },
                            controller: MobileScannerController(
                              detectionSpeed: DetectionSpeed.unrestricted,
                              autoStart: true,
                              facing: CameraFacing.back,
                              returnImage: true,
                            ),
                            borderColor: Colors.red,
                          )
                        : Container()
                    // Container(
                    //     height: 300,
                    //     width: 500,
                    //     child: Transform.rotate(
                    //       angle: pi / 2,
                    //       child: Image.memory(
                    //           filterQuality: FilterQuality.high,
                    //           controller.image!),
                    //     ),
                    //   ),
                    )),
            Expanded(
                flex: 5,
                child: Obx(() => ListView.builder(
                      itemCount: controller.uniqueDevices.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                                '${controller.uniqueDevices.value[index].title}'),
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
                        );
                      },
                    ))),
          ],
        ),
      ),
    );
  }
}
