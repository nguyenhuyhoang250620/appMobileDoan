import 'package:app_mobile_doan/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_screen/models/user_model.dart';

class StudenController extends GetxController{
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference phongHocCollection = FirebaseFirestore.instance.collection('Config');
  List<User> getEmployeeUser = <User>[].obs;
  var siso = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
}