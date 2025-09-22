import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/app_title.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<dynamic> notifications = [];

  Future<void> fetchNotifications() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('notifications')
        .select()
        .eq('user_id', user.id)
        .order('id', ascending: false);

    setState(() {
      notifications = response as List<dynamic>;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppTitle(text: "Shiksha Setu", fontSize: 30,)),
      body: notifications.isEmpty
          ? Center(
              child: Text(AppSettings.text("No notifications yet", "अभी तक कोई सूचना नहीं")),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(
                      item['title'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item['message'] ?? ''),
                  ),
                );
              },
            ),
    );
  }
}

extension on _NotificationsScreenState {
  get AppSettings => null;
}
