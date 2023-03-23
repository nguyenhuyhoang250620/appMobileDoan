import 'dart:typed_data';

import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/app_export.dart';

class HomeController extends GetxController {
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
  RxList danh_sach_mon = [].obs;

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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // MaGV.value = prefs.getString('MaGV')!;
    attendanceDocument(MaGV.value,'');
    listenToDocumentChanges(MaGV.value);
  }

  void listenToDocumentChanges(String MaGV) {
    print("hoang ${MaGV}");
    firestoreInstance
        .collection("Config")
        .where('MaGV', isEqualTo: MaGV)
        // .where('mahocphan.MaHocPhan', isEqualTo: 'MaHocPhan')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        List data = (documentSnapshot.data() as Map)['danhsach'];
        siso.value = data.length;
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist in the database");
      }
    });
  }

  void attendanceDocument(String MaGV, String ma_hoc_phan) {
    print("hoang ${MaGV}");
    FirebaseFirestore.instance
        .collection("Attendance")
        .where('MaGV', isEqualTo: MaGV)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (final doc in querySnapshot.docs) {
          danh_sach_mon.add(doc['MaHocPhan']);
        }
        if (ma_hoc_phan == '') {
          MaHocPhan.value = danh_sach_mon.value.first;
        } else {
          MaHocPhan.value = ma_hoc_phan;
        }
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist in the database");
      }
    });
  }

  void addData() async {
    try {
      // tạo document mới với dữ liệu cần thêm vào
      DocumentReference newDoc = await phongHocCollection.add({
        "sv": [
          {"ten": "hoang"}
        ],
        "phong": {"tenphong": "phonga"},
        "mon": {"tenmon": "tenmon"},
        "thoigian": {"tenca": "tenca"},
        "giangvien": {"tengv": "tengv"},
        "phongban": {"tenphong": "tenphong"}
      });
      print('Thêm dữ liệu thành công: ${newDoc.id}');
    } catch (e) {
      print('Lỗi khi thêm dữ liệu: $e');
    }
  }
}
