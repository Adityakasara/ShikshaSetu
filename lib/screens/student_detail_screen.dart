import 'package:flutter/material.dart';
import '../widgets/app_title.dart';
import '../app_settings.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppTitle(text: "Shiksha Setu", fontSize: 30,)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppSettings.text("Student Details", "छात्र विवरण"),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(AppSettings.text("Name: Rohit Sharma", "नाम: रोहित शर्मा")),
            ),
            ListTile(
              leading: const Icon(Icons.class_),
              title: Text(AppSettings.text("Course: B.Tech - AI/ML", "कोर्स: बी.टेक - एआई/एमएल")),
            ),
            ListTile(
              leading: const Icon(Icons.percent),
              title: Text(AppSettings.text("Attendance: 72%", "उपस्थिति: 72%")),
            ),
            ListTile(
              leading: const Icon(Icons.score),
              title: Text(AppSettings.text("Latest Test Score: 68%", "हाल का टेस्ट स्कोर: 68%")),
            ),
          ],
        ),
      ),
    );
  }
}
