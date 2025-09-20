import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', width: 40, height: 40),
            const SizedBox(width: 10),
            const Text("Dashboard"),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/student');
              },
              child: const Text("Go to Student Detail"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              child: const Text("Go to Notifications"),
            ),
          ],
        ),
      ),
    );
  }
}
