import 'dart:typed_data';

import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '/core/app_export.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  List<User> getEmployeeUser = <User>[].obs;
  var MaSV = "".obs;
  var test = false.obs;
  var test1 = false.obs;
  Uint8List? image;
  @override
  void onInit() {
    listenToDocumentChanges();
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
    });
  }
  

  void listenToDocumentChanges() {
    firestoreInstance
        .collection("User")
        .doc("132")
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if ((documentSnapshot.data() as Map)['GioiTinh'] == 'true') {
          test.value = true;
        } else {
          test.value = false;
        }
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist on the database");
      }
    });
  }
}
