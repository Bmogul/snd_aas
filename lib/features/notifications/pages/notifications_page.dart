import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/notifications/widgets/notifications_content.dart';

/// Notifications page for treatment reminders and updates
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3, // Notifications tab (fourth position)
      child: const SafeArea(
        child: NotificationsContent(),
      ),
    );
  }
}
