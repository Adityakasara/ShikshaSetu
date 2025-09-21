import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? studentData;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final response = await Supabase.instance.client
          .from('students')
          .select()
          .eq('id', user.id)
          .single();

      setState(() {
        studentData = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: studentData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${studentData!['name']}", style: const TextStyle(fontSize: 18)),
                  Text("Email: ${studentData!['email']}", style: const TextStyle(fontSize: 16)),
                  Text("Phone: ${studentData!['phone'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  Text("Gender: ${studentData!['gender'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  Text("Course: ${studentData!['course'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  Text("Sub-Course: ${studentData!['sub_course'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  Text("Attendance: ${studentData!['attendance']}%", style: const TextStyle(fontSize: 16)),
                  Text("Latest Score: ${studentData!['latest_score']}%", style: const TextStyle(fontSize: 16)),
                  Text("Fees: ${studentData!['fees_status']}", style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
    );
  }
}
