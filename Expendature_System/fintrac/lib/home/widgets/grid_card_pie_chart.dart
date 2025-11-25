import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:fintrac/utils/providers/home_dash_provider.dart';
import 'package:provider/provider.dart';

class ExpenseDoughnutChart extends StatefulWidget {
  const ExpenseDoughnutChart({
    super.key,
  });

  @override
  State<ExpenseDoughnutChart> createState() => _ExpenseDoughnutChartState();
}

class _ExpenseDoughnutChartState extends State<ExpenseDoughnutChart> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PieChartProvider>().getTopFiveCatagory());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PieChartProvider>();
    final data = provider.piechartdata;

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SfCircularChart(
        title: ChartTitle(text: 'Expenses',textStyle: TextStyle()),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        series: <CircularSeries>[
          DoughnutSeries<ExpenseData, String>(
            dataSource: data,
            xValueMapper: (ExpenseData d, _) => d.category,
            yValueMapper: (ExpenseData d, _) => d.value,
            pointColorMapper: (ExpenseData d, _) => d.color,
            dataLabelMapper: (ExpenseData d, _) =>
                '${d.category}\n${d.value.toStringAsFixed(1)}%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            innerRadius: '50%',
            radius: '70%',
          ),
        ],
      ),
    );
  }
}


