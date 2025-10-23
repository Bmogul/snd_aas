import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/widgets/shared/animated_page_base.dart';
import 'package:snd_aas/features/auth/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    this.initialRotation = 0.0,
  }) : super(key: key);

  final double initialRotation;

  @override
  Widget build(BuildContext context) {
    return AnimatedPageBase(
      initialRotation: initialRotation,
      rotationDirection: 1.0, // Rotate right for login
      showBackButton: true,
      onBackPressed: () => context.pop(),
      child: LoginForm(
        onLoginPressed: () => context.push('/onboarding', extra: {
          'scaleBegin': 0.8,
          'onGetStarted': () {
            debugPrint('Get started pressed');
            // TODO: Navigate to main app
          },
        }),
        onRegisterPressed: () {
          final state = context.findAncestorStateOfType<AnimatedPageBaseState>();
          final currentRotation = state?.currentRotation ?? 0.0;
          context.push('/register', extra: {
            'currentRotation': currentRotation,
            'scaleBegin': 1.2,
          });
        },
        goBack: () => context.pop(),
      ),
    );
  }
}
