import 'package:flutter/material.dart';

class FeeReminderScreen extends StatelessWidget {
  const FeeReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feesPaid = 20000;
    final totalFees = 50000;

    return Scaffold(
      appBar: AppBar(title: const Text("Fee Reminder"), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Fee Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: feesPaid / totalFees,
              color: Colors.green,
              minHeight: 12,
              backgroundColor: Colors.red.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            Text("Paid: ₹$feesPaid / ₹$totalFees"),
            const SizedBox(height: 30),
            const Text("Reminder: Please clear your pending fees before the due date.",
                style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
