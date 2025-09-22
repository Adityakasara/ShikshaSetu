import 'package:flutter/material.dart';

class ProgressCenterScreen extends StatelessWidget {
  const ProgressCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress Center"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Attendance: 72%",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const LinearProgressIndicator(
              value: 0.72,
              backgroundColor: Colors.grey,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text("Marks Trend",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Text("Chart goes here (fl_chart or any chart lib)"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
