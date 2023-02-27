import 'package:app_mobile_doan/presentation/home_screen/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/core/app_export.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  List<User> getEmployeeUser = <User>[].obs;
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
  Future<void> getUserData()async{
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
  void listenToDocumentChanges() {
    firestoreInstance
        .collection("User")
        .doc("187480201001a3")
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("Document data: ${documentSnapshot.data()}");
        print('HoangNH: ');
        // Cập nhật dữ liệu trong ứng dụng của bạn
      } else {
        print("Document does not exist on the database");
      }
    });
  }
}
