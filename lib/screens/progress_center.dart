import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'profile_screen.dart';
import 'student_bot_screen.dart';
import 'progress_center.dart';
import 'fee_reminder.dart';
import 'risk_analysis_screen.dart';
import 'about_us_screen.dart';
import 'contact_mentor_screen.dart';
import 'login_screen.dart';
import 'pop_prediction_screen.dart';
import 'counselling_screen.dart';
import 'notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? studentName = "Student";
  String? studentEmail = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        studentName = user.userMetadata?['name'] ?? "Student";
        studentEmail = user.email;
      });
    }
  }

  Widget _buildTile(String title, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(studentName ?? "Student"),
              accountEmail: Text(studentEmail ?? ""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.orange),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.orangeAccent],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About Us"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact Mentor"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactMentorScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Welcome, ${studentName ?? 'Student'}"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildTile("Progress Center", Icons.show_chart, Colors.blue,
                 ProgressCenterScreen()),
            _buildTile("Fees", Icons.payment, Colors.green,
                 FeeReminderScreen()),
            _buildTile("Risk Analysis", Icons.warning, Colors.red,
                 RiskAnalysisScreen()),
            _buildTile("Student Bot", Icons.smart_toy, Colors.purple,
                 StudentBotScreen()),
            _buildTile("POP Prediction", Icons.analytics, Colors.teal,
                PopPredictionScreen()),
            _buildTile("Counselling", Icons.psychology, Colors.indigo,
                CounsellingScreen(subject: "Math")), // default subject
          ],
        ),
      ),
    );
  }
}
