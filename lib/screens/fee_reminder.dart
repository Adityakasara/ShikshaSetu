import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeeReminder extends StatefulWidget {
  const FeeReminder({super.key});

  @override
  State<FeeReminder> createState() => _FeeReminderState();
}

class _FeeReminderState extends State<FeeReminder> {
  String? _status;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchFeeStatus();
  }

  Future<void> _fetchFeeStatus() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    try {
      final data = await Supabase.instance.client
          .from('fees')
          .select('status')
          .eq('student_id', userId)
          .maybeSingle();

      setState(() {
        _status = data?['status'];
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fee Reminder")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Text(
                _status == null
                    ? "No fee record available"
                    : (_status == "due"
                        ? "⚠️ Fees Pending"
                        : "✅ Fees Paid"),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _status == "due" ? Colors.red : Colors.green,
                ),
              ),
            ),
    );
  }
}
