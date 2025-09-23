import 'package:flutter/material.dart';

class CounsellingScreen extends StatelessWidget {
  final String subject;

  const CounsellingScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> tips = {
      "Math": [
        "Revise algebra daily",
        "Solve 5 practice problems each day",
        "Join group study"
      ],
      "Science": [
        "Focus on diagrams and experiments",
        "Revise NCERT summaries",
        "Practice previous year questions"
      ],
      "English": [
        "Read 1 article daily",
        "Practice writing essays",
        "Revise grammar rules"
      ],
      "History": [
        "Create a timeline of events",
        "Revise important dates daily",
        "Discuss with peers"
      ],
      "Geography": [
        "Practice maps daily",
        "Focus on physical geography",
        "Revise climate and vegetation"
      ]
    };

    return Scaffold(
      appBar: AppBar(title: Text("Counselling - $subject")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📚 Tips for $subject",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...?tips[subject]?.map((t) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(t),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
