import 'dart:math';
import 'dart:typed_data';

import 'package:app_mobile_doan/presentation/general_screen/controller/general_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  var MaGV = ''.obs;
  var MaHocPhan = ''.obs;
  final random = Random();
  var istest = false.obs;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Attendance');
  @override
  void onInit() {
    mydb.open();
    print('HoangNH: open');
    // getUserData();
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

  Future<void> getDataCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MaGV.value = prefs.getString('MaGV')!;
    MaHocPhan.value = prefs.getString('MaHocPhan')!;
  }

  // Future<void> getUserData() async {
  //   CollectionReference collectionReference =
  //       firestoreInstance.collection("User");
  //   QuerySnapshot querySnapshot = await collectionReference.get();
  //   List<DocumentSnapshot> documents = querySnapshot.docs;
  //   documents.forEach((document) {
  //     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //     User user = User.fromJson(data);
  //     getEmployeeUser.add(user);
  //   });
  // }

  // Future<void> startBarcodeScanStream() async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //           '#ff6666', 'Cancel', true, ScanMode.DEFAULT)!
  //       .listen((event) {
  //     print(event);
  //     listtest.value.add(event);
  //   });
  // }

  Future<void> listenToDocumentChanges(String doc) async {
    await firestoreInstance
        .collection("Config")
        .where('MaGV', isEqualTo: 'phan_van_tien')
        .where('mahocphan.MaHocPhan', isEqualTo: 'an_ninh_mang')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        List data = (documentSnapshot.data() as Map)['danhsach'];
        data.map((e) {
          print('HoangNH: ${e['MaSV']}');
          if (doc == e['MaSV']) {
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
          } else {
            time.value = '';
            TenSV.value = '';
          }
        }).toList();
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist in the database");
      }
    });
    istest.value = true;
  }

  Future<void> saveDatabase(List<DeviceModel> listData) async {
    for (DeviceModel e in listData) {
      if (e.name != '' &&
          e.time != '' &&
          e.time != '' &&
          e.value.isNotEmpty &&
          e.magv != '') {
        final Directory directory = await getTemporaryDirectory();
        final File file =
            File('${directory.path}/image${random.nextInt(1000)}.jpg');
        await file.writeAsBytes(e.value);
        await mydb.db.rawInsert(
            "INSERT INTO Attendance (name, masv, time, image, magv, mahocphan) VALUES (?, ?, ?, ?, ?, ?);",
            [e.name, e.title, e.time, file.path, e.magv, MaHocPhan.value]);
        // await addUser(e.magv!, 'an_toan', '101B1', e.time!, e.time!,
        //     e.name!, e.title);
        await addDiemDanh(
            MaGV.value, MaHocPhan.value, e.title, e.name!, e.time!);
      }
    }
    uniqueDevices.clear();
  }

  Future<void> addUser(String MaGV, String MaHocPhan, String MaPhong,
      String CheckIn, String CheckOunt, String MaSV, String TenSV) {
    return usersRef
        .add({
          'MaGV': MaGV,
          'MaHocPhan': MaHocPhan,
          'MaPhong': 'MaPhong',
          'DiemDanh': [
            {
              'CheckIn': CheckIn,
              'CheckOut': CheckOunt,
              'MaSV': MaSV,
              'TenSV': TenSV
            }
          ]
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> addDiemDanh(
    String MaGV,
    String MaHocPhan,
    String MaSV,
    String TenSV,
    String ThoiGian,
  ) async {
    final QuerySnapshot snapshot = await usersRef
        .where('MaGV', isEqualTo: MaGV)
        .where('MaHocPhan', isEqualTo: MaHocPhan)
        .get();
    final DocumentReference docRef = snapshot.docs.first.reference;
    final Map<String, dynamic> newData = {
      'DiemDanh': FieldValue.arrayUnion([
        {
          'MaSV': MaSV,
          'TenSV': TenSV,
          'ThoiGian': ThoiGian,
        }
      ])
    };
    return docRef.update(newData);
  }
}
