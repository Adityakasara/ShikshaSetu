import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {"text": "Marks from assessment have updated. Check your attendance.", "time": "18 hrs ago"},
      {"text": "Prepare for your weekly exams.", "time": "2 days ago"},
      {"text": "Pay your exam fees on time.", "time": "4 days ago"},
      {"text": "Mentor meeting scheduled for next Monday.", "time": "1 week ago"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications"), backgroundColor: Colors.orange),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.orange),
              title: Text(notifications[index]["text"]!),
              subtitle: Text(notifications[index]["time"]!,
                  style: const TextStyle(color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}
