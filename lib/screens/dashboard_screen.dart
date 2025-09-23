import 'package:flutter/material.dart';

// ✅ Corrected imports
import 'progress_center.dart';
import 'fee_reminder.dart';
import 'risk_analysis_screen.dart';
import 'student_bot_screen.dart';
import 'pop_prediction_screen.dart';
import 'counselling_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _buildTile(BuildContext context, String title, IconData icon,
      Color color, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Example notifications popup
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Notifications"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                          title: Text("Marks from assessment updated"),
                          subtitle: Text("18 hrs ago")),
                      ListTile(
                          title: Text("Prepare for your weekly exams"),
                          subtitle: Text("2 days ago")),
                      ListTile(
                          title: Text("Pay your exam fees on time"),
                          subtitle: Text("3 days ago")),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/login");
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildTile(context, "Progress", Icons.show_chart, Colors.blue,
              const ProgressCenter()),
          _buildTile(context, "Fees", Icons.payment, Colors.green,
              const FeeReminder()), // ✅ corrected name
          _buildTile(context, "Risk Analysis", Icons.warning, Colors.red,
              const RiskAnalysisScreen()),
          _buildTile(context, "Student Bot", Icons.smart_toy, Colors.purple,
              const StudentBotScreen()),
          _buildTile(context, "POP Prediction", Icons.analytics,
              Colors.orange, const PopPredictionScreen()),
          _buildTile(context, "Counselling", Icons.psychology,
              Colors.teal, const CounsellingScreen(subject: "General")),
        ],
      ),
    );
  }
}
