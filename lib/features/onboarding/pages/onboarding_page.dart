import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/shared/gradient_background.dart';
import 'package:snd_aas/features/onboarding/widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key, required this.onGetStarted}) : super(key: key);

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          SafeArea(
            child: OnboardingContent(onGetStarted: onGetStarted),
          ),
        ],
      ),
    );
  }
}
