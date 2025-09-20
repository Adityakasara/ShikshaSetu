import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Student Profile")),
      body: Center(
        child: user == null
            ? const Text("No user logged in")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/logo.png"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.email ?? "No email",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.id,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
