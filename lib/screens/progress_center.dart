import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressCenterScreen extends StatefulWidget {
  const ProgressCenterScreen({super.key});

  @override
  State<ProgressCenterScreen> createState() => _ProgressCenterScreenState();
}

class _ProgressCenterScreenState extends State<ProgressCenterScreen> {
  int? attendancePercent;
  List<int> marks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      // ✅ Attendance
      final attendanceResponse = await Supabase.instance.client
          .from('attendance')
          .select('percentage')
          .eq('student_id', user.id)
          .maybeSingle();

      // ✅ Marks
      final marksResponse = await Supabase.instance.client
          .from('marks')
          .select('score')
          .eq('student_id', user.id);

      setState(() {
        attendancePercent = attendanceResponse?['percentage'];
        marks =
            (marksResponse as List).map((m) => m['score'] as int).toList();
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      debugPrint("Error fetching progress data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress Center"),
        backgroundColor: scheme.primary,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ✅ Attendance Section
                  Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "📊 Attendance",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          attendancePercent == null
                              ? const Text("No attendance data available")
                              : Column(
                                  children: [
                                    LinearProgressIndicator(
                                      value: attendancePercent! / 100,
                                      minHeight: 20,
                                      color: attendancePercent! < 75
                                          ? scheme.error
                                          : scheme.primary,
                                      backgroundColor: scheme.surfaceVariant,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "$attendancePercent%",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: attendancePercent! < 75
                                            ? scheme.error
                                            : scheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Marks Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "📈 Marks Trend",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          marks.isEmpty
                              ? const Text("No marks data available")
                              : SizedBox(
                                  height: 220,
                                  child: LineChart(
                                    LineChartData(
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(show: true),
                                      borderData: FlBorderData(show: true),
                                      lineBarsData: [
                                        LineChartBarData(
                                          isCurved: true,
                                          spots: List.generate(
                                            marks.length,
                                            (i) => FlSpot(
                                                i.toDouble(),
                                                marks[i].toDouble()),
                                          ),
                                          color: scheme.primary,
                                          dotData: FlDotData(show: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
