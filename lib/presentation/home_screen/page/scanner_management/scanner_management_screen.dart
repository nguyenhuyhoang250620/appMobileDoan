import 'dart:async';
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multiselect/multiselect.dart';

// import 'flutter_barcode_scanner.dart';

class ScannerScreen extends StatefulWidget {
  ScannerScreen({required this.homeController});
  @override
  final HomeController homeController;
  State<StatefulWidget> createState() {
    return ScannerState();
  }
}

class ScannerState extends State<ScannerScreen> {
  @override
  void initState() {
    print("welcome to page home");
    super.initState();
  }

  StreamSubscription? broadcastSubscription;
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.DEFAULT)
        .then((value) {
      print(value);
    });
  }

  List<String> list = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: Get.height,
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                "Hệ thống quản lý máy quét",
                style: AppStyle.titleTopPage,
              ),
            ),
          ),
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
                  icon: Icon(Icons.scanner),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                  ),
                  onChanged: (p0) {
                    print(p0);
                  },
                  enabled: true,
                  //TungVD: list location camera init from server with isMonitoring = true
                  options: list,
                  //TungVD: list item selected filter from allvmslocationlist
                  selectedValues: [],
                  whenEmpty: 'Lựa chọn máy quét',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                ...List.generate(10, (index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        startBarcodeScanStream();
                      }
                      if (index == 1) {
                        Get.offAndToNamed(AppRoutes.diviceScreen);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Phòng $index",
                                style: AppStyle.txtInterMedium14
                                    .copyWith(color: Colors.white),
                              )),
                          Text("Tòa B1",
                              style: AppStyle.txtInterMedium14
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
