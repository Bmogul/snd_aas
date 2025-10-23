import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/widgets/shared/gradient_background.dart';
import 'package:snd_aas/features/auth/widgets/greeting_content.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
      value: 0.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    final currentValue = _controller.value;
    context.push('/login', extra: {
      'currentRotation': currentValue,
      'scaleBegin': 0.8,
    });
  }

  void _navigateToRegister() {
    final currentValue = _controller.value;
    context.push('/register', extra: {
      'currentRotation': currentValue,
      'scaleBegin': 1.2,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(rotationAnimation: _controller),
          SafeArea(
            child: GreetingContent(
              onLoginPressed: _navigateToLogin,
              onRegisterPressed: _navigateToRegister,
            ),
          ),
        ],
      ),
    );
  }
}
