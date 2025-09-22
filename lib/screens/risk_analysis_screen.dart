import 'package:flutter/material.dart';

class RiskAnalysisScreen extends StatelessWidget {
  const RiskAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final risks = [
      {"factor": "Low Attendance", "status": "⚠️ At Risk (<75%)"},
      {"factor": "Declining Marks", "status": "⚠️ Need Attention"},
      {"factor": "Fees Pending", "status": "⚠️ Critical"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Risk Analysis"), backgroundColor: Colors.orange),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: risks.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(risks[index]["factor"]!),
            subtitle: Text(risks[index]["status"]!),
          );
        },
      ),
    );
  }
}
