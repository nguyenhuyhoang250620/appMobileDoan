import 'package:app_mobile_doan/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class SystemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemState();
  }
}

class SystemState extends State<SystemScreen> {
  @override
  Widget build(BuildContext context) {
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
                "Hệ thống quản lí sinh viên",
                style: AppStyle.titleTopPage,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropDownMultiSelect(
                  icon: Icon(Icons.search),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                  ),
                  onChanged: (p0) {
                    print(p0);
                  },
                  enabled: true,
                  //TungVD: list location camera init from server with isMonitoring = true
                  options: ["1", "2"],
                  //TungVD: list item selected filter from allvmslocationlist
                  selectedValues: [],
                  whenEmpty: 'Tìm kiếm sinh viên',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
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
                              Text("Họ tên : Nguyễn Huy Hoàng"),
                              Text("Mã số sinh viên : 1874802010013"),
                              Text("Thời gian vào : 7:30'"),
                              Text("Thời gian ra : 11:40'")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
