import 'package:flutter/material.dart';
import 'counselling_screen.dart';

class PopPredictionScreen extends StatelessWidget {
  const PopPredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final Map<String, double> attendance = {
      "Math": 65,
      "Science": 72,
      "English": 80,
      "History": 68,
      "Geography": 90,
    };

    final Map<String, double> marks = {
      "Math": 45,
      "Science": 55,
      "English": 60,
      "History": 40,
      "Geography": 75,
    };

    return Scaffold(
      appBar: AppBar(title: const Text("POP Prediction")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("📌 Attendance Prediction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ...attendance.entries.map((entry) {
              final subject = entry.key;
              final value = entry.value;
              final shortage = value < 75
                  ? "⚠️ Needs ${(75 - value).ceil()}% more attendance"
                  : "✅ Safe";

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text("$subject - $value%"),
                  subtitle: Text(shortage),
                  trailing: value < 75
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CounsellingScreen(subject: subject),
                              ),
                            );
                          },
                          child: const Text("Get Help"),
                        )
                      : null,
                ),
              );
            }),

            const SizedBox(height: 24),
            const Text("📌 Marks Prediction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ...marks.entries.map((entry) {
              final subject = entry.key;
              final value = entry.value;
              final risk = value < 50
                  ? "❌ Risk of failing"
                  : "✅ On track";

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text("$subject - $value marks"),
                  subtitle: Text(risk),
                  trailing: value < 50
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CounsellingScreen(subject: subject),
                              ),
                            );
                          },
                          child: const Text("Get Help"),
                        )
                      : null,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
