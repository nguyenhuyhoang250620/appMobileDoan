import 'dart:typed_data';

import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '/core/app_export.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference phongHocCollection = FirebaseFirestore.instance.collection('Config');
  List<User> getEmployeeUser = <User>[].obs;
  var MaSV = "".obs;
  var test = false.obs;
  var test1 = false.obs;
  Uint8List? image;
  var siso = 0.obs;

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
      .collection("Config")
      .where('MaGV', isEqualTo: 'Hoang')
      .where('mahocphan.MaHocPhan', isEqualTo: 'MaHocPhan')
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        List data =(documentSnapshot.data() as Map)['danhsach'];
        siso.value = data.length;
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
       "sv":[
        {
            "ten":"hoang"
        }
       ],
       "phong":{
            "tenphong":"phonga"
       },
       "mon":{
            "tenmon":"tenmon"
       },
       "thoigian":{
            "tenca":"tenca"
       },
       "giangvien":{
            "tengv":"tengv"
       },
       "phongban":{
            "tenphong":"tenphong"
       }
    });
    print('Thêm dữ liệu thành công: ${newDoc.id}');
  } catch (e) {
    print('Lỗi khi thêm dữ liệu: $e');
  }
}

}
