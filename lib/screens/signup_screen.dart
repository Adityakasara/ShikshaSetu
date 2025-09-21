import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/app_title.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart' hide LoginScreen;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController(); // ✅ New
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _loading = false;
  String? _error;

  late AnimationController _controller;
  late Animation<Color?> _gradient1;
  late Animation<Color?> _gradient2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _gradient1 = ColorTween(
      begin: Colors.blue.shade200,
      end: Colors.blue.shade600,
    ).animate(_controller);

    _gradient2 = ColorTween(
      begin: Colors.orange.shade200,
      end: Colors.orange.shade600,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (_passwordController.text != _confirmController.text) {
      setState(() => _error = "Passwords do not match");
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // ✅ Create account in Supabase Auth
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        // ✅ Insert extra info into "students" table
        await Supabase.instance.client.from('students').insert({
          'id': response.user!.id,
          'name': _nameController.text.trim(),   // ✅ Added name
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
        });

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
          );
        }
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false, TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboard,
      maxLength: label == "Phone Number" ? 10 : null,
      decoration: InputDecoration(
        labelText: label,
        counterText: "",
        suffixIcon: label == "Phone Number" && controller.text.length == 10
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
        floatingLabelStyle:
            const TextStyle(color: Color.fromARGB(255, 233, 81, 6)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 53, 188, 225), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_gradient1.value!, _gradient2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppTitle(text: ''),
                    const SizedBox(height: 40),

                    // ✅ New Name field
                    _buildTextField("Name", _nameController),
                    const SizedBox(height: 16),

                    _buildTextField("Email", _emailController,
                        keyboard: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    _buildTextField("Phone Number", _phoneController,
                        keyboard: TextInputType.phone),
                    const SizedBox(height: 16),
                    _buildTextField("Password", _passwordController,
                        isPassword: true),
                    const SizedBox(height: 16),
                    _buildTextField("Confirm Password", _confirmController,
                        isPassword: true),

                    if (_error != null) ...[
                      const SizedBox(height: 10),
                      Text(_error!,
                          style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _loading ? null : _signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 14),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Sign Up"),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 137, 247),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
