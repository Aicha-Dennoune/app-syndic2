import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 40, color: Colors.red, title: 'Impayés'),
            PieChartSectionData(value: 60, color: Colors.green, title: 'Payé'),
          ],
        ),
      ),
    );
  }
}
