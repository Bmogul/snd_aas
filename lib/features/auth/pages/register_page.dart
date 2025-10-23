import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/widgets/shared/animated_page_base.dart';
import 'package:snd_aas/features/auth/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key? key,
    this.initialRotation = 0.0,
  }) : super(key: key);

  final double initialRotation;

  @override
  Widget build(BuildContext context) {
    return AnimatedPageBase(
      initialRotation: initialRotation,
      rotationDirection: -1.0, // Rotate left for register
      showBackButton: true,
      onBackPressed: () => context.pop(),
      child: RegisterForm(
        goBack: () => context.pop(),
        onGooglePressed: () => context.push('/onboarding', extra: {
          'scaleBegin': 0.6,
          'onGetStarted': () {
            debugPrint('Get started pressed');
            // TODO: Navigate to main app
          },
        }),
        onApplePressed: () => context.push('/onboarding', extra: {
          'scaleBegin': 0.6,
          'onGetStarted': () {
            debugPrint('Get started pressed');
            // TODO: Navigate to main app
          },
        }),
      ),
    );
  }
}
