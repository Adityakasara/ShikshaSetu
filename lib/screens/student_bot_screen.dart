import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentBotScreen extends StatefulWidget {
  const StudentBotScreen({super.key});

  @override
  State<StudentBotScreen> createState() => _StudentBotScreenState();
}

class _StudentBotScreenState extends State<StudentBotScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final text = _controller.text.trim();
    setState(() {
      _messages.add({"sender": "user", "type": "text", "text": text});

      if (text.toLowerCase().contains("attendance")) {
        _messages.add({
          "sender": "bot",
          "type": "attendance",
          "value": 72, // Example %
        });
      } else if (text.toLowerCase().contains("marks")) {
        _messages.add({
          "sender": "bot",
          "type": "marks",
          "values": [45, 55, 62, 70, 80, 76, 85], // Example marks
        });
      } else if (text.toLowerCase().contains("fee")) {
        _messages.add({
          "sender": "bot",
          "type": "fee",
          "text": "Your fee due date is 10th Oct. Pending: ₹15,000"
        });
      } else {
        _messages.add({
          "sender": "bot",
          "type": "text",
          "text": "I can help with attendance, marks, and fee reminders."
        });
      }
    });

    _controller.clear();
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    final isUser = msg["sender"] == "user";

    // ✅ Normal text messages
    if (msg["type"] == "text") {
      return Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser ? Colors.orange : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            msg["text"]!,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    // ✅ Attendance Widget
    if (msg["type"] == "attendance") {
      final percent = msg["value"] as int;
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("📊 Attendance Status:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: Colors.grey[300],
              color: percent < 75 ? Colors.red : Colors.green,
              minHeight: 20,
            ),
            const SizedBox(height: 4),
            Text("$percent% Attendance",
                style: TextStyle(color: percent < 75 ? Colors.red : Colors.green)),
          ],
        ),
      );
    }

    // ✅ Marks Graph Widget
    if (msg["type"] == "marks") {
      final List<int> values = List<int>.from(msg["values"]);
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("📈 Marks Trend:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: List.generate(values.length,
                          (i) => FlSpot(i.toDouble(), values[i].toDouble())),
                      color: Colors.blue,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ✅ Fee Reminder Widget
    if (msg["type"] == "fee") {
      return Align(
        alignment: Alignment.centerLeft,
        child: Card(
          color: Colors.yellow[100],
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    msg["text"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Bot"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask the bot...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
