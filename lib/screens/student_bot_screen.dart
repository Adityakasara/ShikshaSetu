// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:postgrest/src/types.dart';

class Student {
  final String name;
  final double attendance;
  final double averageMarks;
  final double feesDue;

  const Student({
    required this.name,
    required this.attendance,
    required this.averageMarks,
    required this.feesDue,
  });

  static Student? fromJson(PostgrestMap response) {
    return null;
  }
}

class StudentBotScreen extends StatelessWidget {
  final Student student;
  const StudentBotScreen({super.key, required this.student});

  String _generateAdvice(Student student) {
    List<String> tips = [];

    if (student.attendance < 75) {
      tips.add("⚠️ Your attendance is below 75%. Try to attend classes regularly.");
    } else {
      tips.add("✅ Attendance is good. Keep it up!");
    }

    if (student.averageMarks < 50) {
      tips.add("📉 Marks are low. Spend extra time revising weak subjects.");
    } else if (student.averageMarks < 70) {
      tips.add("📊 Marks are average. Aim for consistent practice.");
    } else {
      tips.add("🎉 Excellent marks! Consider mentoring peers.");
    }

    if (student.feesDue > 0) {
      tips.add("💰 You have pending fees of ₹${student.feesDue}. Please clear them soon.");
    } else {
      tips.add("✅ No fee dues. Good job staying on track!");
    }

    return tips.join("\n\n");
  }

  @override
  Widget build(BuildContext context) {
    final advice = _generateAdvice(student);

    return Scaffold(
      appBar: AppBar(title: const Text("Student Bot")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello, ${student.name}! 👋",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(advice, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
