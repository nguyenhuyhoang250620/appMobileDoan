import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:app_mobile_doan/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController{
  final firestore = FirebaseFirestore.instance;
  TextEditingController txtmessage = TextEditingController();
  var MaGV = ''.obs;
  var URL = ''.obs;
  var filename = ''.obs;
  var isLoadingImage = false.obs;  
  var isCheckPickFile = false.obs;  
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
  Future<void> pickFileImage() async{
        final picker = ImagePicker();
        final pickedFile = await picker.getImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final fileName = path.basename(file.path);

          // Tạo đường dẫn tới thư mục mới trong Firebase Storage
          final storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
          final uploadTask = storageRef.putFile(file);

          final snapshot = await uploadTask.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          URL.value = url;
          filename.value = fileName;
          isLoadingImage.value = true;
        }
  }
    Future<void> sendMessage(String message,String imageUrl) async {
      print('HoangNH: $imageUrl');
      final data = {
        'from': MaGV.value,
        'message': message,
        'thoigian': '${DateTime.now().hour}:${DateTime.now().minute}',
        'timestamp': FieldValue.serverTimestamp(),
        'imageUrl':imageUrl
      };
      await firestore.collection('Messenger').add(data);
    }
}