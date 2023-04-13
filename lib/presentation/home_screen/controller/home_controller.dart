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
  final CollectionReference teacherAttendance =
      FirebaseFirestore.instance.collection('Attendance_Teacher');
  List<User> getEmployeeUser = <User>[].obs;
  var MaSV = "".obs;
  var test = false.obs;
  var test1 = false.obs;
  Uint8List? image;
  var siso = 0.obs;
  var MaGV = ''.obs;
  var MaHocPhan = ''.obs;
  var MaPhong = ''.obs;
  var ThoiGianBatDau = ''.obs;
  RxList danh_sach_mon = [].obs;
  @override
  void onInit() {
    getDataCode();
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


  Future<void> getDataCode ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MaGV.value = prefs.getString('MaGV')!;
    MaHocPhan.value =prefs.getString('MaHocPhan')!;
    listenToDocumentChanges(MaGV.value,MaHocPhan.value);
  }


  void listenToDocumentChanges(String MaGV,String ma_hoc_phan) {
    firestoreInstance
        .collection("Config")
        .where('MaGV', isEqualTo: MaGV)
        .where('mahocphan.MaHocPhan',isEqualTo: ma_hoc_phan)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        ThoiGianBatDau.value = (documentSnapshot.data() as Map)['maca']['ThoiGian'];
        MaPhong.value = (documentSnapshot.data() as Map)['maphong']['MaPhong'];
        List data = (documentSnapshot.data() as Map)['danhsach'];
        siso.value = data.length;
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist in the database");
      }
    });
  }

 

  Future<void> CheckInTeacher()async{
    final QuerySnapshot snapshot = await teacherAttendance
      .where('MaGV', isEqualTo: MaGV.value)
      .where('MaHocPhan', isEqualTo: MaHocPhan.value)
      .get();
    final DocumentReference docRef = snapshot.docs.first.reference;
    final Map<String, dynamic> newData = {
      'DiemDanh': FieldValue.arrayUnion([
        {
          'CheckIn': DateTime.now(),
        }
      ])
    };
    return docRef.update(newData);
  }
}
