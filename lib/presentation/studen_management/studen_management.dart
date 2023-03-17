import 'package:app_mobile_doan/presentation/divice_screen/controller/divice_controller.dart';
import 'package:app_mobile_doan/presentation/studen_management/studen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

import '../../core/app_export.dart';
import '../../core/utils/constants.dart';
class StudenManagement extends GetWidget<StudenController>{
  @override
  Widget build(BuildContext context) {
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
          "Quản lý sinh viên",
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
                  ],
                )),
          ),
          Expanded(
            flex: 8,
            child:StreamBuilder<QuerySnapshot>(
              stream: controller.phongHocCollection.where('MaGV',isEqualTo: 'Hoang').where('mahocphan.MaHocPhan',isEqualTo: 'MaHocPhan').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                print('HoangNH: ${documents.length}');
                List<dynamic> data = [];
                documents.forEach((document) {
                  print('HoangNH: ${(document.data() as Map)['danhsach']}');
                  data += (document.data() as Map)['danhsach'];
                });
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                    height: 150,
                    width: Get.width,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: darkTextColor),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              padding: EdgeInsets.all(appPadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child:FadeInImage(
                                      placeholder: AssetImage('assets/images/image_not_found.png'),
                                      image: NetworkImage(
                                        '${data[index]['url']}',
                                        scale: 1.0
                                      ),
                                      imageErrorBuilder: (context, error, stackTrace) => Icon(
                                        Icons.person,
                                        color: darkTextColor,
                                        size: 40,
                                      ),
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 10,
                                    ),
                              ),
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
                                Text("${data[index]['TenSV']}",style: AppStyle.txtCartTitle,),
                                 RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Mã số sinh viên : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${data[index]['MaSV']}',
                                        style: AppStyle.txtContentCard.copyWith(color: blue)
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Khoá : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${data[index]['Khoa']}',
                                        style: AppStyle.txtContentCard.copyWith(color: green)
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Email : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${data[index]['Email']}',
                                        style: AppStyle.txtContentCard.copyWith(color: red),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Sđt : ',
                                        style: AppStyle.txtContentCard
                                      ),
                                      TextSpan(
                                        text: '${data[index]['SoDT']}',
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
                  },
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
