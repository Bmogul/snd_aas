import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/settings/widgets/settings_content.dart';

/// Settings page for app configuration
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      currentIndex: 0, // Settings tab (first position)
      child: SafeArea(
        child: SettingsContent(),
      ),
    );
  }
}
