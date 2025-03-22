import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 500, color: Colors.blue)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 600, color: Colors.blue)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 700, color: Colors.blue)]),
          ],
        ),
      ),
    );
  }
}
