import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/presentation/chat_group/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/utils/constants.dart';

class ChatGroupScreen extends GetWidget<ChatController>{
  ScrollController _scrollController = ScrollController();
  
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
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                 Expanded(
                  flex: 1,
                   child: Container(
                    height: Get.height,
                    width: Get.width,
                     child: StreamBuilder<QuerySnapshot>(
                      stream: controller.firestore.collection('Messenger').orderBy('timestamp', descending: false).snapshots(),
                      builder: (context, snapshot) {               
                        if (!snapshot.hasData) {
                          return const Text('Loading...');
                        }
                         final messages = snapshot.data!.docs;
                        Future.delayed(Duration(milliseconds: 50), () {
                          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                        });
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            controller.URL.value =  message['imageUrl'];
                            return  message['from'] == controller.MaGV.value
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
                                      Image.network(
                                        message['imageUrl'],
                                        errorBuilder: (context, error, stackTrace) {
                                          return SizedBox(height: 1,);
                                        },
                                        ),
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
                                SizedBox(height: 40,)
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
                                        Image.network(
                                        message['imageUrl'],
                                        errorBuilder: (context, error, stackTrace) {
                                          return SizedBox(height: 1,);
                                        },
                                        ),
                                        Text(message['thoigian'],style: TextStyle(color: darkTextColor,fontSize: 10),)
                                      ]
                                    ),
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40,)
                              ],
                            );
                          },
                        );
                      },
                                   ),
                   ),
                 ),
                SizedBox(height: 60,)
              ],
            ),
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
              child: Obx(() => TextField(
                controller: controller.txtmessage,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send,color: controller.isCheckPickFile.value?controller.isLoadingImage.value?blue:grey:blue,),
                    onPressed: () {
                      if(controller.isCheckPickFile.value){
                        if(controller.isLoadingImage.value){
                         controller.sendMessage(controller.txtmessage.text,controller.URL.value);
                          controller.filename.value="";
                          controller.URL.value =  "";
                          controller.isLoadingImage = false.obs;  
                          controller.isCheckPickFile = false.obs;
                          controller.txtmessage.clear();
                        }
                      }
                      else{
                        controller.sendMessage(controller.txtmessage.text,"");
                        controller.txtmessage.clear();
                      }
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      controller.isCheckPickFile.value = true;
                      controller.pickFileImage();
                    },
                  ),
                  border: InputBorder.none,
                  hintText: controller.filename.value == ''?'Nhắn tin':controller.filename.value,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
              ),)
            ),
          ),
       ],
      ),
    ),
    );;
  }

}