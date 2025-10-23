import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/widgets/shared/app_bottom_nav.dart';

/// Main layout wrapper with bottom navigation
/// Used by pages in the main app sections
class MainLayout extends StatelessWidget {
  const MainLayout({
    Key? key,
    required this.child,
    required this.currentIndex,
  }) : super(key: key);

  final Widget child;
  final int currentIndex;

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/settings');
        break;
      case 1:
        context.go('/progress');
        break;
      case 2:
        context.go('/home');
        break;
      case 3:
        context.go('/notifications');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }
}
