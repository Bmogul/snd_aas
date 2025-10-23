import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/widgets/shared/gradient_background.dart';
import 'package:snd_aas/features/onboarding/widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key, this.onGetStarted}) : super(key: key);

  final VoidCallback? onGetStarted;

  void _handleGetStarted(BuildContext context) {
    if (onGetStarted != null) {
      onGetStarted!();
    } else {
      // Navigate to home page
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          SafeArea(
            child: OnboardingContent(onGetStarted: () => _handleGetStarted(context)),
          ),
        ],
      ),
    );
  }
}
