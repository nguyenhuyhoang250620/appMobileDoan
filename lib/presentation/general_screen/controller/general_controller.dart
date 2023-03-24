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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // MaGV.value = prefs.getString('MaGV')!;
    attendanceDocument(MaGV.value);
  }

  void listenToDocumentChanges(String MaGV,String ma_hoc_phan) {
    print("hoang ${MaGV}");
    firestoreInstance
        .collection("Config")
        .where('MaGV', isEqualTo: MaGV)
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
