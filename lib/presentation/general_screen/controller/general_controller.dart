import 'dart:typed_data';
import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/general_model.dart';
import '/core/app_export.dart';

class GeneralController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference phongHocCollection =
      FirebaseFirestore.instance.collection('Config');
  List<User> getEmployeeUser = <User>[].obs;
  var MaSV = "".obs;
  var test = false.obs;
  var test1 = false.obs;
  Uint8List? image;
  var siso = 0.obs;
  var MaGV = 'phan_van_tien'.obs;
  var MaHocPhan = ''.obs;
  List<MaHocPhanModel> danh_sach_mon = <MaHocPhanModel>[].obs;

  @override
  void onInit() {
    getMaGV();
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

  Future<void> getMaGV() async {
    // Lưu trữ một giá trị
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('MaGV',MaGV.value);
    attendanceDocument(MaGV.value);
  }
  void attendanceDocument(String MaGV) {
    print("hoang ${MaGV}");
    FirebaseFirestore.instance
        .collection("Attendance")
        .where('MaGV', isEqualTo: MaGV)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (final doc in querySnapshot.docs) {
          MaHocPhanModel model =  MaHocPhanModel(
            MaHocPhan: doc['MaHocPhan'],
            TenHocPhan: doc['TenHocPhan']
          );
          danh_sach_mon.add(model);
        }
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist in the database");
      }
    });
  }
}
