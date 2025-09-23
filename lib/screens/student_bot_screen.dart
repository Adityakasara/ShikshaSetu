import 'package:flutter/material.dart';

class StudentBotScreen extends StatefulWidget {
  const StudentBotScreen({super.key});

  @override
  State<StudentBotScreen> createState() => _StudentBotScreenState();
}

class _StudentBotScreenState extends State<StudentBotScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
    });
    _controller.clear();

    // 🔹 Basic trained responses (rule-based)
    String reply;
    if (text.toLowerCase().contains("attendance")) {
      reply = "📅 Remember to keep attendance above 75% to stay safe!";
    } else if (text.toLowerCase().contains("marks")) {
      reply = "📊 Don’t worry, keep practicing daily and your marks will improve.";
    } else if (text.toLowerCase().contains("fees")) {
      reply = "💰 Please make sure your pending fees are cleared soon.";
    } else {
      reply = "🤖 I’m your study buddy! Ask me about attendance, marks, or fees.";
    }

    setState(() {
      _messages.add({"role": "bot", "text": reply});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Bot 🤖"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.orange[200] : Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg["text"] ?? ""),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Type your question...",
                    contentPadding: EdgeInsets.all(12),
                  ),
                  onSubmitted: _sendMessage,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _sendMessage(_controller.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
