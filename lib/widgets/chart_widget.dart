import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  final List<double> values;
  final String title;
  final Color lineColor;

  const ChartWidget({
    super.key,
    required this.values,
    required this.title,
    this.lineColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return Center(child: Text("No $title data available"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  spots: List.generate(
                    values.length,
                    (i) => FlSpot(i.toDouble(), values[i]),
                  ),
                  color: lineColor,
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
