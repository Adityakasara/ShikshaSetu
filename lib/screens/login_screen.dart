import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _login(BuildContext context) async {
    try {
      final supabase = Supabase.instance.client;

      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: "https://zazvohgkqnatkxmlmgjj.supabase.co/auth/v1/callback",
      );

      final user = supabase.auth.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", height: 100),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => _login(context),
              icon: const Icon(Icons.login),
              label: const Text("Login with Google"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
