import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RiskAnalysisScreen extends StatelessWidget {
  const RiskAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy student data (replace with Supabase later)
    double overallRiskScore = 0.65;
    Map<String, double> subjectAttendance = {
      "Math": 72,
      "Science": 68,
      "English": 85,
      "History": 78,
      "Geography": 60,
    };
    Map<String, double> subjectMarks = {
      "Math": 55,
      "Science": 45,
      "English": 70,
      "History": 62,
      "Geography": 50,
    };

    String riskLevel;
    Color riskColor;
    if (overallRiskScore > 0.7) {
      riskLevel = "High Risk";
      riskColor = Colors.red;
    } else if (overallRiskScore > 0.4) {
      riskLevel = "Medium Risk";
      riskColor = Colors.orange;
    } else {
      riskLevel = "Low Risk";
      riskColor = Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Risk Analysis"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔶 Overall Risk Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.warning, size: 40, color: riskColor),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Overall Risk Level",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(riskLevel,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: riskColor)),
                      ],
                    ),
                    const Spacer(),
                    Text("${(overallRiskScore * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: riskColor)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔶 Attendance Risk Chart
            const Text("📌 Attendance Risk",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < subjectAttendance.keys.length) {
                            return Text(
                              subjectAttendance.keys.elementAt(index),
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(subjectAttendance.length, (index) {
                    final value =
                        subjectAttendance.values.elementAt(index).toDouble();
                    return BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                        toY: value,
                        color: value < 75 ? Colors.red : Colors.green,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      )
                    ]);
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔶 Marks Risk Chart
            const Text("📌 Marks Risk",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < subjectMarks.keys.length) {
                            return Text(
                              subjectMarks.keys.elementAt(index),
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(subjectMarks.length, (index) {
                        return FlSpot(index.toDouble(),
                            subjectMarks.values.elementAt(index).toDouble());
                      }),
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 4,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blueAccent.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔶 Suggestions
            const Text("💡 Suggestions",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("⚠️ Attend extra classes for weak subjects."),
                    SizedBox(height: 8),
                    Text("📖 Revise Science & Geography regularly."),
                    SizedBox(height: 8),
                    Text("💰 Check pending fees to reduce stress risk."),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
