import 'dart:math';
import 'dart:typed_data';

import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../database/attendance_database.dart';
import '../models/divice_model.dart';
import '/core/app_export.dart';

class DiviceController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  List<User> getEmployeeUser = <User>[].obs;
  var MaSV = "".obs;
  var TenSV = "".obs;
  var time = "".obs;
  var test = true.obs;
  var test1 = false.obs;
  var index = 0.obs;
  Uint8List? image;
  RxList<String> listtest = <String>[].obs;
  RxList<Uint8List> list = <Uint8List>[].obs;
  RxList<DeviceModel> lancuoi = <DeviceModel>[].obs;
  RxList<DeviceModel> uniqueDevices = <DeviceModel>[].obs;
  final MyDb mydb = MyDb();
  final homeController = Get.find<HomeController>();
  final random = Random();

  @override
  void onInit() {
    mydb.open();
     print('HoangNH: open');
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
        .collection("Config")
        .where('MaGV', isEqualTo: homeController.MaGV.value)
        .where('mahocphan.MaHocPhan', isEqualTo: 'MaHocPhan')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final documentSnapshot = querySnapshot.docs.first;
          List data =(documentSnapshot.data() as Map)['danhsach'];
            data.map((e){
              print('HoangNH: ${e['MaSV']}');
              if(doc == e['MaSV']){
                print('HoangNH: vaokhong');
                firestoreInstance
                    .collection("User")
                    .doc(doc)
                    .snapshots()
                    .listen((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    TenSV.value = '${(documentSnapshot.data() as Map)["TenSV"]}';
                    time.value = DateTime.now().toString();
                    // Cập nhật dữ liệu trong ứng dụng của bạn
                  } else {
                    print("Document does not exist on the database");
                  }
                });
              }

            }).toList();
          // Cập nhật dữ liệu trong ứng dụng của bạn
        } else {
          print("Document does not exist in the database");
        }
      });
  }


  Future<void> saveDatabase(List<DeviceModel> listData) async{
    print('HoangNH: luu');
      for(DeviceModel e in listData) {
        if(e.name != '' && e.time != '' && e.time != '' && e.value.isNotEmpty && e.magv != ''){
          final Directory directory = await getTemporaryDirectory();
          final File file = File('${directory.path}/image${random.nextInt(1000)}.jpg');
          await file.writeAsBytes(e.value);
          await mydb.db.rawInsert(
            "INSERT INTO Attendance (name, masv, time, image, magv) VALUES (?, ?, ?, ?, ?);",
            [e.name, e.title, e.time,file.path,e.magv]);
        }
      }
    uniqueDevices.clear();
  }
}
