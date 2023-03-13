import 'dart:typed_data';

import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/divice_model.dart';
import '/core/app_export.dart';

class DiviceController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  List<User> getEmployeeUser = <User>[].obs;
  var MaSV = "".obs;
  var test = true.obs;
  var test1 = false.obs;
  Uint8List? image;
  RxList<String> listtest = <String>[].obs;
  RxList<Uint8List> list = <Uint8List>[].obs;
  RxList<DeviceModel> lancuoi = <DeviceModel>[].obs;
  RxList<DeviceModel> uniqueDevices = <DeviceModel>[].obs;
  @override
  void onInit() {
    // listenToDocumentChanges('B123');
    getUserData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUserData() async {
    CollectionReference collectionReference =
        firestoreInstance.collection("User");
    QuerySnapshot querySnapshot = await collectionReference.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      User user = User.fromJson(data);
      getEmployeeUser.add(user);
    });
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.DEFAULT)!
        .listen((event) {
      print(event);
      listtest.value.add(event);
    });
  }

  void listenToDocumentChanges(String doc) {
    firestoreInstance
        .collection("User")
        .doc(doc)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('HoangNH: ${(documentSnapshot.data() as Map)["TenSV"]}');
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist on the database");
      }
    });
  }
}
