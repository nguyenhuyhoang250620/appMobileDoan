import 'package:app_mobile_doan/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_screen/models/user_model.dart';

class StudenController extends GetxController{
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference phongHocCollection = FirebaseFirestore.instance.collection('Config');
  List<User> getEmployeeUser = <User>[].obs;
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
  Future<void> getUserData() async {
    CollectionReference collectionReference =
        firestoreInstance.collection("Config");
    QuerySnapshot querySnapshot = await collectionReference.where('MaGV',isEqualTo: 'giangvien@gmail.com').get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((document) {
      List<dynamic> data = (document.data() as Map)['danhsach'];
      // List<User> myList = data.values.map((value) => User.fromJson(value)).toList();
      // print('HoangNH danhsach:${data.runtimeType}');
      List<User> myList = data.map((item) => User.fromJson(item)).toList();
      getEmployeeUser = myList;
    });
  }
}