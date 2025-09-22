import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://zazvohgkqnatkxmlmgjj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InphenZvaGdrcW5hdGt4bWxtZ2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzNjI3NjIsImV4cCI6MjA3MzkzODc2Mn0.SO0GxDZ0_Z3rFjSL72WMjWMjOCOwW8eYM8cDFgbvYOE",
  );

  final session = Supabase.instance.client.auth.currentSession;

  runApp(MyApp(
    initialPage: session != null
        ? const DashboardScreen()
        : const LoginScreen(),
  ));
}

class MyApp extends StatelessWidget {
  final Widget initialPage;
  const MyApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ShikshaSetu",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: initialPage,
    );
  }
}
