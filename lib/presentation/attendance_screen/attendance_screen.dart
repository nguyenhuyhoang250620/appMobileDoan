import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AttendanceState();
  }

}
class AttendanceState extends State<AttendanceScreen>{
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    return Scaffold(
      appBar:AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: darkTextColor,),
        onPressed: () {
          Get.offAndToNamed(AppRoutes.homeScreen);
        },
      ),
      backgroundColor: Colors.white,
      title: Text(
          "Hệ thống điểm danh",
          style: AppStyle.titleTopPage,
        ),),
      body: Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.only(left: appPadding*5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text('Chọn thời gian', style: AppStyle.txtContentCard.copyWith(color: darkTextColor)),
                            SizedBox(width: 10,),
                            Icon(
                                  Icons.edit_calendar_rounded,
                                  color: Colors.blue,
                                  size: 24.0,
                                  semanticLabel: 'Xem lịch',
                                ),
                            SizedBox(width: 10,),
                            Container(
                                width: 150,
                                child:DateTimePicker(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      type: DateTimePickerType.date,
                                      dateMask: 'dd-MM-yyyy',
                                      initialValue: DateTime.now().toString(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      icon: const Icon(Icons.event, size: 24),
                                      onChanged: (val) {
                                        
                                      },
                                      // validator: (val) {
                                      //   print(val);
                                      //   vmsController.runNameFilter(val!);
                                      //   return null;
                                      // },
                                    ),
                              )  
                            
                        ],
                      ),
                    ),
                    Text("Sỹ số lớp : 22/30, Vắng 2"),
                    TextButton(
                        onPressed: () {
                          Get.dialog(
                            Dialog(
                                child: Container(
                                  height: Get.height,
                                  width: Get.width,
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
                                                height: 80,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(8.0)),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: darkTextColor)
                                                        ),
                                                        child: ClipOval(
                                                          child: FadeInImage(
                                                            placeholder: AssetImage('assets/images/image_not_found.png'),
                                                            image: NetworkImage(
                                                              '${(document.data() as Map)["url"].toString()}',
                                                              scale: 1.0
                                                            ),
                                                            imageErrorBuilder: (context, error, stackTrace) =>Icon(
                                                                Icons.person,
                                                                color: darkTextColor,
                                                                size: 40,
                                                              ),
                                                            fit: BoxFit.cover,
                                                            height: 50,
                                                            // width: 50,
                                                          ),
                                                        )
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 7,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text("${(document.data() as Map)["TenSV"].toString()}",style: AppStyle.txtCartTitle,),
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: 'MSV: ',
                                                                    style: AppStyle.txtContentCard
                                                                  ),
                                                                  TextSpan(
                                                                    text: '${(document.data() as Map)["MaSV"].toString()}',
                                                                    style: AppStyle.txtContentCard.copyWith(color: blue)
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: cardA,
                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(6.0),bottomRight: Radius.circular(6.0))
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
                          );
                        },
                        child: Text("Bấm vào để xem chi tiết"))
                  ],
                )),
          ),
          Expanded(
            flex: 8,
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
                    height: 100,
                    width: Get.width,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: darkTextColor),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: darkTextColor)
                            ),
                            child: ClipOval(
                              child: FadeInImage(
                                placeholder: AssetImage('assets/images/image_not_found.png'),
                                image: NetworkImage(
                                  '${(document.data() as Map)["url"].toString()}',
                                  scale: 1.0
                                ),
                                imageErrorBuilder: (context, error, stackTrace) =>Icon(
                                    Icons.person,
                                    color: darkTextColor,
                                    size: 60,
                                  ),
                                fit: BoxFit.cover,
                                height: 68,
                                // width: 50,
                              ),
                            )
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${(document.data() as Map)["TenSV"].toString()}",style: AppStyle.txtCartTitle,),
                                 RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Mã số sinh viên : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${(document.data() as Map)["MaSV"].toString()}',
                                        style: AppStyle.txtContentCard.copyWith(color: blue)
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Thời gian vào : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '7:30',
                                        style: AppStyle.txtContentCard.copyWith(color: green)
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Thời gian ra : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '7:30',
                                        style: AppStyle.txtContentCard.copyWith(color: red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            width: 10,
                            decoration: BoxDecoration(
                              color: cardA,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(6.0),bottomRight: Radius.circular(6.0))
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
    ),
    );
  }
}
