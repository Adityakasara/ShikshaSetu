import 'package:flutter/material.dart';

class FeeReminderScreen extends StatelessWidget {
  // Dummy fee data (later connect with Supabase or Razorpay API)
  final Map<String, Map<String, dynamic>> fees = {
    "Tuition Fee": {"amount": 50000.0, "paid": 30000.0},
    "Library Fee": {"amount": 2000.0, "paid": 2000.0},
    "Exam Fee": {"amount": 3000.0, "paid": 1500.0},
    "Lab Fee": {"amount": 4000.0, "paid": 0.0},
    "Transport Fee": {"amount": 10000.0, "paid": 7000.0},
  };

  FeeReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double totalAmount = fees.values.fold(0, (sum, f) => sum + f["amount"]);
    double totalPaid = fees.values.fold(0, (sum, f) => sum + f["paid"]);
    double totalDue = totalAmount - totalPaid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Reminder"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Overall Stats
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Overall Fee Status",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Total Fees: ₹$totalAmount",
                        style: const TextStyle(fontSize: 16)),
                    Text("Paid: ₹$totalPaid",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.green)),
                    Text("Pending: ₹$totalDue",
                        style: TextStyle(
                            fontSize: 16,
                            color: totalDue > 0 ? Colors.red : Colors.green)),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: totalPaid / totalAmount,
                      backgroundColor: Colors.red.shade100,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.green.shade400),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Individual Fee Breakdown
            const Text("Fee Breakdown",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 10),

            Column(
              children: fees.entries.map((entry) {
                final title = entry.key;
                final amount = entry.value["amount"] as double;
                final paid = entry.value["paid"] as double;
                final due = amount - paid;

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(Icons.payment,
                        color: due > 0 ? Colors.red : Colors.green),
                    title: Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total: ₹$amount"),
                        Text("Paid: ₹$paid",
                            style: const TextStyle(color: Colors.green)),
                        Text(
                          due > 0 ? "Pending: ₹$due" : "✅ Cleared",
                          style: TextStyle(
                              color: due > 0 ? Colors.red : Colors.green),
                        ),
                      ],
                    ),
                    trailing: due > 0
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Payment Initiated"),
                                  content: Text(
                                      "Proceed to pay ₹$due for $title.\n(Later this will connect to Razorpay/UPI.)"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Payment for $title marked as successful (demo).")));
                                        },
                                        child: const Text("Pay Now")),
                                  ],
                                ),
                              );
                            },
                            child: const Text("Pay Now"),
                          )
                        : const Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
