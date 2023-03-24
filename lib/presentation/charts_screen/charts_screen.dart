import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/core/utils/constants.dart';
import 'package:app_mobile_doan/presentation/charts_screen/charts_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'charts_model.dart';

List<ChartModel> chartData = [
  ChartModel('A', 1),
  ChartModel('B', 1),
  ChartModel('C', 1),
];
class ChartsScreen extends GetWidget<ChartsController>{
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
          "Thống kê số liệu",
          style: AppStyle.titleTopPage,
        ),),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.all(appPadding),
              margin: EdgeInsets.only(top: appPadding*2),
              child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: [
                  PieChartSectionData(
                  color: cardA,
                  value: 50,
                  title: '50%',
                  radius: 150,
                  titleStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                    shadows: [Shadow(color: Colors.white, blurRadius: 2)],
                  ),
                  badgePositionPercentageOffset: .98,
                ),
                PieChartSectionData(
                  color: cardB,
                  value: 20,
                  title: '20%',
                  radius: 150,
                  titleStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                  ),
                  badgePositionPercentageOffset: .98,
                ),
                PieChartSectionData(
                  color: cardC,
                  value: 10,
                  title: '10%',
                  radius: 150,
                  titleStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                    shadows: [Shadow(color: Colors.red, blurRadius: 2)],
                  ),
                  badgePositionPercentageOffset: .98,
                ),
                ],
              ),
            ),
            ),
            Row(
              children: [
                Container(height: 40,width: 80,color: cardA,),
                SizedBox(width: 10,),
                Text(": Đi muộn"),
              ],
            ),
            SizedBox(height: 10,),
             Row(
              children: [
                Container(height: 40,width: 80,color: cardB,),
                SizedBox(width: 10,),
                Text(": Về sớm"),
              ],
            ),
             SizedBox(height: 10,),
             Row(
              children: [
                Container(height: 40,width: 80,color: cardC,),
                SizedBox(width: 10,),
                Text(": Vắng mặt"),
              ],
            ),
          ],
        ),
      )
    );
  }

}