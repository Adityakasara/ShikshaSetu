// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart' as dash;
import 'screens/student_bot_screen.dart' as bot;
import 'screens/settings_screen.dart';
import 'screens/fee_reminder.dart';

// 🔹 Theme Notifier for Dark Mode
class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  ThemeMode get currentMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://zazvohgkqnatkxmlmgjj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InphenZvaGdrcW5hdGt4bWxtZ2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzNjI3NjIsImV4cCI6MjA3MzkzODc2Mn0.SO0GxDZ0_Z3rFjSL72WMjWMjOCOwW8eYM8cDFgbvYOE",
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "ShikshaSetu",
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeNotifier.currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/dashboard': (context) => const dash.DashboardScreen(),
            '/bot': (context) => const bot.StudentBotScreen(),
            '/settings': (context) => const SettingsScreen(),
            // The progress_center.dart export didn't provide a 'ProgressCenter' widget; use a simple attendance placeholder or replace with the correct class name from progress_center.dart
            '/attendance': (context) => Scaffold(
              appBar: AppBar(title: const Text('Attendance')),
              body: const Center(child: Text('Attendance screen placeholder')),
            ),
            '/fee': (context) => const FeeReminder(),
          },
        );
      },
    );
  }
}
