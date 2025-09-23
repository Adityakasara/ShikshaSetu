// lib/models/student_model.dart

// ignore_for_file: implementation_imports

import 'package:postgrest/src/types.dart';

class Student {
  final String name;
  final String email;
  final double attendance;
  final double averageMarks;
  final double feesDue;

  const Student({
    required this.name,
    required this.email,
    required this.attendance,
    required this.averageMarks,
    required this.feesDue,
  });

  /// Convert JSON (from Supabase) to Student object
  factory Student.fromJson(PostgrestMap json) {
    return Student(
      name: (json['name'] ?? 'Unknown') as String,
      email: (json['email'] ?? '') as String,
      attendance: (json['attendance'] ?? 0).toDouble(),
      averageMarks: (json['average_marks'] ?? 0).toDouble(),
      feesDue: (json['fees_due'] ?? 0).toDouble(),
    );
  }

  /// Convert Student object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'attendance': attendance,
      'average_marks': averageMarks,
      'fees_due': feesDue,
    };
  }
}
