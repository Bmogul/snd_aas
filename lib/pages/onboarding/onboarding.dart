import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/gradient_background.dart';
import 'package:snd_aas/pages/onboarding/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key, required this.onGetStarted}) : super(key: key);

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _buildFloatingCircle(
      double size,
      Color color,
      AlignmentGeometry alignment,
    ) {
      return Align(
        alignment: alignment,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.2),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          Positioned.fill(
            child: Stack(
              children: [
                _buildFloatingCircle(
                  75,
                  theme.colorScheme.tertiary,
                  Alignment(-.5, .5),
                ),
                _buildFloatingCircle(
                  250,
                  theme.colorScheme.secondary,
                  Alignment(-1.8, 1.1),
                ),
                _buildFloatingCircle(
                  50,
                  theme.colorScheme.primary,
                  Alignment(-.8, -.6),
                ),
                _buildFloatingCircle(
                  300,
                  theme.colorScheme.tertiary,
                  Alignment(3.0, -1.2),
                ),
              ],
            ),
          ),
          SafeArea(
            child: OnboardingContent(onGetStarted: onGetStarted),
          ),
        ],
      ),
    );
  }
}
