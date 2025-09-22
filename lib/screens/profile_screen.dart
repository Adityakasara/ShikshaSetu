import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          "Profile details will appear here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
