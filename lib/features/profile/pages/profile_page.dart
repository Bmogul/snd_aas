import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/profile/widgets/profile_content.dart';

/// Profile page for user account management
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 4, // Profile tab (fifth position)
      child: const SafeArea(
        child: ProfileContent(),
      ),
    );
  }
}
