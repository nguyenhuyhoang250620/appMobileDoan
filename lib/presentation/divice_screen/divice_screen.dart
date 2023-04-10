import 'dart:math';
import 'dart:typed_data';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/core/utils/constants.dart';
import 'package:app_mobile_doan/presentation/divice_screen/controller/divice_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';

import '../general_screen/controller/general_controller.dart';
import 'models/divice_model.dart';

class DiviceScreen extends StatefulWidget {
  const DiviceScreen({Key? key}) : super(key: key);

  @override
  State<DiviceScreen> createState() => _DiviceState();
}

class _DiviceState extends State<DiviceScreen> {
  @override
  void initState() {
    super.initState();
  }

  String barcode = 'Tap  to scan';
  var color = "1".obs;
  final controller = Get.find<DiviceController>();
  final homeController = Get.find<HomeController>();
  final List<String> listnua = [];
  final List<Uint8List> listnuahay = [];
  final List<DeviceModel> landau = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Điểm danh',
          style: AppStyle.txtInterMedium18
              .copyWith(color: darkTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: bgColor,
        actions: [
          IconButton(
              onPressed: () {
                controller.saveDatabase(controller.uniqueDevices);
              },
              icon: Icon(
                Icons.save,
                color: darkTextColor,
                size: 25,
              )),
          IconButton(
              onPressed: () {
                Get.offAndToNamed(AppRoutes.homeScreen);
              },
              icon: Icon(
                Icons.close,
                color: darkTextColor,
                size: 25,
              ))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: Obx(
                  () => AiBarcodeScanner(
                    validateText: '',
                    onScannerStarted: (p0) {}, // link to be validated
                    validateType: ValidateType.contains,
                    // canPop: true,
                    // allowDuplicates: true,
                    errorColor: Colors.red,
                    successColor:
                        controller.test1.value ? Colors.red : Colors.green,

                    onScan: (String value) {
                      debugPrint(value);
                      controller.MaSV.value = value;
                      controller.listenToDocumentChanges(controller.MaSV.value);
                      controller.test1.value = false;
                      Future.delayed(Duration(milliseconds: 2500), () {
                        controller.test1.value = true;
                      });
                    },
                    onDetect: (p0) {
                      if (controller.MaSV.isNotEmpty &&
                          controller.istest.value == true) {
                        controller.image = p0.image;
                        Future.delayed(Duration(milliseconds: 100), () {
                          DeviceModel model = DeviceModel(
                              time: controller.time.value,
                              name: controller.TenSV.value,
                              title: controller.MaSV.value,
                              value: controller.image!,
                              magv: homeController.MaGV.value);
                          controller.lancuoi.value.add(model);
                          List<DeviceModel> devices = controller.lancuoi.value;
                          controller.uniqueDevices.value = devices
                              .where((device) => device.title != null)
                              .toSet()
                              .toList();
                        });
                        controller.istest.value = false;
                      }
                    },
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.unrestricted,
                      autoStart: true,
                      facing: CameraFacing.back,
                      returnImage: true,
                    ),
                    borderColor: Colors.red,
                  ),
                )),
            Expanded(
                flex: 4,
                child: Obx(() => ListView.builder(
                      itemCount: controller.uniqueDevices.length,
                      itemBuilder: (context, index) {
                        List<DeviceModel> reversedList = controller.uniqueDevices.toList().reversed.toList();
                        return Container(
                          height: 100,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    child: InkWell(
                                      onTap: () {
                                        Get.dialog(Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Transform.rotate(
                                            angle: pi / 2,
                                            child: Image.memory(
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high,
                                                controller.uniqueDevices[index].value),
                                          ),
                                        ));
                                      },
                                      child: Transform.rotate(
                                        angle: pi / 2,
                                        child: Image.memory(
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                            controller.uniqueDevices[index].value),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => Text(
                                            '${controller.uniqueDevices.value[index].name}'),
                                      ),
                                      Obx(() => Text(
                                          '${controller.uniqueDevices.value[index].title}')),
                                      Obx(
                                        () => Text(
                                            '${controller.uniqueDevices.value[index].time!.substring(0,20)}'),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        );
                      },
                    ))),
          ],
        ),
      ),
    );
  }
}
