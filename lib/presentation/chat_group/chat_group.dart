import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/chat_group/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/utils/constants.dart';

class ChatGroupScreen extends GetWidget<ChatController>{
  
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
          "Chat group",
          style: AppStyle.titleTopPage,
        ),),
      body: Container(
      height: Get.height,
      width: Get.width,
      color: green.withOpacity(0.2),
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: controller.firestore.collection('Messenger').orderBy('timestamp', descending: false).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }
              final messages = snapshot.data!.docs;
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return message['from'] == controller.MaGV.value
                  ?Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.all(appPadding),
                          padding: EdgeInsets.all(appPadding),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            Flexible(
                              child: Text(
                                message['message'],
                                style: TextStyle(color:darkTextColor),
                                ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              message['thoigian'],
                              style: TextStyle(color:darkTextColor,fontSize: 10),
                            )
                            ],
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),
                      ),
                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.all(appPadding),
                          padding: EdgeInsets.all(appPadding),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                              message['from'],
                                style: TextStyle(color: cardB,fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                message['message'],
                                style: TextStyle(color: darkTextColor),
                              ),
                              SizedBox(height: 8,),
                              Text(message['thoigian'],style: TextStyle(color: darkTextColor,fontSize: 10),)
                            ]
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 10,
            child: Theme(
              data: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: TextField(
                controller: controller.txtmessage,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send,color: blue,),
                    onPressed: () {
                      controller.sendMessage(controller.txtmessage.text);
                      controller.txtmessage.clear();
                    },
                  ),
                  border: InputBorder.none,
                  hintText: 'Nhắn tin',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
              ),
            ),
          ),
       ],
      ),
    ),
    );;
  }

}