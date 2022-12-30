import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class AnalysisView extends StatelessWidget {
  AnalysisView({Key? key}) : super(key: key);

  List<Sales> data =
  [ Sales('Jan', 5),
    Sales('Feb', 17),
    Sales('Mar', 29),
    Sales('Apr', 33),
    Sales('May', 15),
    Sales('Jun', 10),
    Sales('Jul', 35),
    Sales('Aug', 40),
    Sales('Sep', 41),
    Sales('Oct', 33),
    Sales('Nov', 39),
    Sales('Dec', 45),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تحليل المبيعات',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body:Container(
        padding: EdgeInsets.all(10),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<Sales,String>> [
            LineSeries(
                dataSource: data,
                xValueMapper: (datum, index) => datum.month,
                yValueMapper: (datum, index) => datum.numOfSales,
              name: 'المبيعات',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ) ,
    );
  }

}
class Sales{
  String? month;
  int? numOfSales;

  Sales(this.month, this.numOfSales);
}