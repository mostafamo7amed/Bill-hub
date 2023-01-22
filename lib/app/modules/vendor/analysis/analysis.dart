import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/analysis.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../invoice/invoice_cubit/states.dart';

class AnalysisView extends StatefulWidget {
  AnalysisView({Key? key}) : super(key: key);

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {


  
  @override
  void initState() {
    InvoiceCubit.getCubit(context).GetSales();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'تحليل المبيعات',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.allSales.isNotEmpty,
            builder: (context) =>Container(
              padding: EdgeInsets.all(10),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Sales,String>> [
                  LineSeries(
                    dataSource: cubit.allSales,
                    xValueMapper: (datum, index) => datum.month,
                    yValueMapper: (datum, index) => datum.numOfSales,
                    name: 'المبيعات',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ) ,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
