import 'package:flutter/material.dart';

// Replaced external screen imports with simple local placeholders to avoid missing URI errors.
// These placeholders can be moved to separate files later if desired.

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: const Center(child: Text('Progress Screen')),
    );
  }
}

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fees')),
      body: const Center(child: Text('Fees Screen')),
    );
  }
}

class RiskScreen extends StatelessWidget {
  const RiskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Risk Analysis')),
      body: const Center(child: Text('Risk Analysis Screen')),
    );
  }
}

class StudentBotScreen extends StatelessWidget {
  const StudentBotScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Bot')),
      body: const Center(child: Text('Student Bot Screen')),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: const Center(child: Text('About Us Screen')),
    );
  }
}

class ContactMentorScreen extends StatelessWidget {
  const ContactMentorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Mentor')),
      body: const Center(child: Text('Contact Mentor Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Login Screen')),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Shiksha",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text: "Setu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                "ShikshaSetu Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
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
              leading: const Icon(Icons.bar_chart),
              title: const Text("Progress"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProgressScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.payments),
              title: const Text("Fees"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeesScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text("Risk Analysis"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiskScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.smart_toy),
              title: const Text("Student Bot"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StudentBotScreen()),
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
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              context,
              "Attendance",
              Icons.school,
              "68% present",
              Colors.blue,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProgressScreen()),
              ),
            ),
            _buildCard(
              context,
              "Marks",
              Icons.bar_chart,
              "Trend: Downward 📉",
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProgressScreen()),
              ),
            ),
            _buildCard(
              context,
              "Fees",
              Icons.payment,
              "Due: ₹10,000",
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeesScreen()),
              ),
            ),
            _buildCard(
              context,
              "Risk",
              Icons.warning,
              "High Risk 🚨",
              Colors.red,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiskScreen()),
              ),
            ),
            _buildCard(
              context,
              "Student Bot",
              Icons.smart_toy,
              "Ask me anything",
              Colors.purple,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StudentBotScreen()),
              ),
            ),
            _buildCard(
              context,
              "About Us",
              Icons.info,
              "Know more",
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUsScreen()),
              ),
            ),
            _buildCard(
              context,
              "Contact Mentor",
              Icons.contact_mail,
              "Reach your mentor",
              Colors.indigo,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactMentorScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      String subtitle, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
