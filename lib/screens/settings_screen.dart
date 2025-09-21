import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: false,
            onChanged: (val) {
              // TODO: Connect to global theme later
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Change Language"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Language change coming soon")),
              );
            },
          ),
        ],
      ),
    );
  }
}
