import 'dart:io';
import 'dart:math';
import 'package:app_mobile_doan/presentation/attendance_screen/attendance_model.dart';
import 'package:app_mobile_doan/presentation/home_screen/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../database/attendance_database.dart';
import '../divice_screen/models/divice_model.dart';

class AttendanceController extends GetxController{
    final homeController = Get.find<HomeController>();
    MyDb mydb = MyDb();
    RxList listDataAttendance =[].obs;    
    RxList listStudent =[].obs;    
    var isGetdata = false.obs;
    RxList<AttendanceModel> listEmployeeAttendance = <AttendanceModel>[].obs;
    RxList<Student> listStudentLeave = <Student>[].obs;
    final random = Random();
    var comat = 0.obs;
    final firestoreInstance = FirebaseFirestore.instance;
    

    @override
    void onInit() {
      mydb.open();
      getdata();
      super.onInit();
    }
  String convertTimeToShow(String datetime){
    DateTime tempDate =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(datetime);
    String date = DateFormat("hh:mm").format(tempDate);
    return date;
  }
  
  Future<void> getdata() async{
    Future.delayed(const Duration(milliseconds: 1000), () async {
       listStudent.value = await mydb.db.rawQuery('SELECT DISTINCT masv FROM Attendance ').then((element){
        return element;
      });
      List<AttendanceModel> data = [];
      for(var item in listStudent){
        await mydb.db.rawQuery('SELECT * FROM Attendance WHERE masv = "${item['masv']}" AND magv = "${homeController.MaGV.value}" AND mahocphan = "${homeController.MaHocPhan.value}"').then((element){
            AttendanceModel model = AttendanceModel(
              id: random.nextInt(1000),
              name: element.first['name'].toString(),
              image: element.first['image'].toString(),
              masv: item['masv'],
              timeIn: convertTimeToShow(element.first['time'].toString()),
              timeOut: convertTimeToShow(element.last['time'].toString())
            );
            data.add(model);
        return element;
      });
      }
      if(data.isEmpty){
        isGetdata.value = false;
      }
      isGetdata.value = true;
      comat.value = data.length;
      listEmployeeAttendance.value = data;
      getDataStudent(listEmployeeAttendance);
    });
  }
  Future<void> deleteAllDatabases() async {
    print('HoangNH: xoas');
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'Attendance.db');
      mydb.deleteDatabase(path);
  }

  void getDataStudent(List<AttendanceModel> dataList) {
    var MaGV = homeController.MaGV.value;
    var ma_hoc_phan = homeController.MaHocPhan.value;
    firestoreInstance
        .collection("Config")
        .where('MaGV', isEqualTo: MaGV)
        .where('mahocphan.MaHocPhan',isEqualTo: ma_hoc_phan)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        List data = (documentSnapshot.data() as Map)['danhsach'];
        data.map((e){
          dataList.map((doc){
            if(e['MaSV'] != doc.masv){
              Student model = Student(
                cccd: e['CCCD'],
                email: e['Email'],
                gioiTinh: e['GioiTinh'],
                khoa: e['Khoa'],
                maSV: e['MaSV'],
                namSinh: e['NamSinh'],
                soDT: e['SoDT'],
                tenSV: e['TenSV']
              );
              listStudentLeave.add(model);
            }
          }).toList();
          
        }).toList();
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist in the database");
      }
    });
  }

}