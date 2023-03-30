import 'package:app_mobile_doan/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController{
  final firestore = FirebaseFirestore.instance;
  TextEditingController txtmessage = TextEditingController();
  var MaGV = ''.obs;
  @override
  void onInit() {
    getMaGV();
    super.onInit();
  }
  Future<void> getMaGV()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('HoangNH: ${prefs.getString('MaGV')}');
    MaGV.value = prefs.getString('MaGV')!;
  }

  Future<void> sendMessage(String message) async {
    final data = {
      'from': MaGV.value,
      'message': message,
      'thoigian': '${DateTime.now().hour}:${DateTime.now().minute}',
      'timestamp': FieldValue.serverTimestamp(),
    };
    await firestore.collection('Messenger').add(data);
}
}