import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/student_detail_screen.dart';
import 'screens/notifications_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: "https://zazvohgkqnatkxmlmgjj.supabase.co", // 🔑 your Supabase URL
    anonKey:
        "sb_publishable_0D1vHk5-e5CY4J81q1i_fw_lmq9WgPR", // 🔑 your anon key
  );

  runApp(const ShikshaSetuApp());
}

class ShikshaSetuApp extends StatelessWidget {
  const ShikshaSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShikshaSetu',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/student': (context) => const StudentDetailScreen(),
        '/notifications': (context) => const NotificationsScreen(),
      },
    );
  }
}
