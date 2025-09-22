import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMentorScreen extends StatelessWidget {
  const ContactMentorScreen({super.key});

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'yourmail@example.com', // Replace with your email
      query: 'subject=Student Support&body=Hello Mentor,',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Mentor"), backgroundColor: Colors.orange),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _sendEmail,
          icon: const Icon(Icons.email),
          label: const Text("Send Email to Mentor"),
        ),
      ),
    );
  }
}
