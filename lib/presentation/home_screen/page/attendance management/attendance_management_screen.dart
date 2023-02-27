import 'package:app_mobile_doan/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AttendanceState();
  }
}

class AttendanceState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: Get.height,
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                "Hệ thống điểm danh",
                style: AppStyle.titleTopPage,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Text("Sỹ số lớp : 22/30, Vắng 2"),
                    TextButton(
                        onPressed: () {
                          Get.dialog(
                            Container(
                              height: 100,
                              width: 400,
                              child: Dialog(
                                child: Container(
                                  height: Get.height*0.8,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () => Get.back(),
                                            icon: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text("Sinh viên vắng mặt",style: AppStyle.titleTopPage,),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child:StreamBuilder<QuerySnapshot>(
                                          stream: users.snapshots(),
                                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (snapshot.hasError) {
                                              return Text('Something went wrong');
                                            }

                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Text("Loading");
                                            }

                                            return new ListView(
                                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                return Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(8.0)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding: EdgeInsets.all(20),
                                                        child: Icon(
                                                          Icons.people,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 8,
                                                      child: Container(
                                                        padding: EdgeInsets.all(5),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text("Họ tên : ${(document.data() as Map)["TenSV"].toString()}"),
                                                            Text("Mã số sinh viên : ${(document.data() as Map)["MaSV"].toString()}"),
                                                            Text("Thời gian vào : 7:30'"),
                                                            Text("Thời gian ra : 11:40'")
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                              }).toList(),
                                            );
                                          },
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ),
                            )
                          );
                        },
                        child: Text("Bấm vào để xem chi tiết"))
                  ],
                )),
          ),
          Expanded(
            flex: 7,
            child:StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.people,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Họ tên : ${(document.data() as Map)["TenSV"].toString()}"),
                                Text("Mã số sinh viên : ${(document.data() as Map)["MaSV"].toString()}"),
                                Text("Thời gian vào : 7:30'"),
                                Text("Thời gian ra : 11:40'")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                  }).toList(),
                );
              },
            )
          )
        ],
      ),
    );
  }
}
