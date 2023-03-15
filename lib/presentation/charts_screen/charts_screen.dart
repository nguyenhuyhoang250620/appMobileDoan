import 'package:app_mobile_doan/core/app_export.dart';
import 'package:app_mobile_doan/core/utils/constants.dart';
import 'package:app_mobile_doan/presentation/charts_screen/charts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'charts_model.dart';

List<ChartModel> chartData = [
  ChartModel('A', 1),
  ChartModel('B', 1),
  ChartModel('C', 1),
  ChartModel('D', 1),
  ChartModel('D', 1),
  ChartModel('D', 1),
  ChartModel('D', 1),
  ChartModel('D', 1),
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
      body: SfCircularChart(
      series: <CircularSeries>[
        PieSeries<ChartModel, String>(
          dataSource: chartData,
          xValueMapper: (ChartModel data, _) => data.x,
          yValueMapper: (ChartModel data, _) => data.y,
        ),
      ],
    ),
    );
  }

}