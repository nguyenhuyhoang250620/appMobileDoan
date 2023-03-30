import 'package:app_mobile_doan/core/utils/constants.dart';
import 'package:flutter/material.dart';

import 'home_model.dart';

List<HomeModel> modelList = [
  HomeModel(title: "Attendance", content: "Danh sách điểm danh",icon: Icon(Icons.checklist_rtl_sharp,size: 30,color: bgColor,),color: cardA!),
  HomeModel(title: "Management", content: "Hồ sơ sinh viên",icon: Icon(Icons.people_alt_outlined,size: 30,color: bgColor),color: cardB!),
  HomeModel(title: "Statistical", content: "Thống kê dữ liệu",icon: Icon(Icons.stacked_bar_chart,size: 30,color: bgColor),color: cardC!),
  HomeModel(title: "Holiday", content: "Ngày nghỉ lễ",icon: Icon(Icons.calendar_month,size: 30,color: bgColor),color: Colors.yellow[900]!),
  HomeModel(title: "Scanner", content: "Máy quét điểm danh",icon: Icon(Icons.video_camera_front_sharp,size: 30,color: bgColor),color: Colors.black),
  HomeModel(title: "Chat", content: "Trò chuyện",icon: Icon(Icons.chat,size: 30,color: bgColor),color: cardD!),
];