import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'risk_analysis_screen.dart';
import 'progress_center.dart';
import 'fee_reminder.dart';
import 'student_bot_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Student? student;

  @override
  void initState() {
    super.initState();
    loadStudent();
  }

  Future<void> loadStudent() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final email = user.email;
    if (email == null) return;

    final response = await Supabase.instance.client
        .from('students')
        .select()
        .eq('email', email)
        .maybeSingle();

    if (response != null) {
      setState(() {
        student = Student(
          name: response['name'] ?? "Student",
          attendance: (response['attendance'] ?? 0).toDouble(),
          averageMarks: (response['average_marks'] ?? 0).toDouble(),
          feesDue: (response['fees_due'] ?? 0).toDouble(),
        );
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
              accountName: Text(student?.name ?? "Student"),
              accountEmail: Text(Supabase.instance.client.auth.currentUser?.email ?? ""),
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
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.smart_toy),
              title: const Text("Student Bot"),
              onTap: () {
                if (student != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentBotScreen(student: student!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please wait, loading student data...")),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
                if (mounted) Navigator.popUntil(context, (r) => r.isFirst);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Welcome, ${student?.name ?? 'Student'}"),
        backgroundColor: Colors.orange,
      ),
      body: student == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildTile("Progress", Icons.show_chart, Colors.blue,
                      const ProgressCenterScreen()),
                  _buildTile("Fees", Icons.payment, Colors.green,
                      const FeeReminderScreen()),
                  _buildTile("Risk", Icons.warning, Colors.red,
                      const RiskAnalysisScreen()),
                  _buildTile("Bot", Icons.smart_toy, Colors.purple,
                      StudentBotScreen(student: student!)),
                ],
              ),
            ),
    );
  }
}
