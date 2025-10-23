import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/gradient_background.dart';
import 'package:snd_aas/pages/greeting/login_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    this.initialRotation = 0.0,
  }) : super(key: key);

  final double initialRotation;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
      value: widget.initialRotation,
    );

    // Animate forward (rotate right) when entering login page
    _controller.animateTo(
      widget.initialRotation + 1.0,
      duration: const Duration(seconds: 2),
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final currentValue = _controller.value;
    final targetRotation = currentValue - 1.0;

    // Start rotation animation (don't await - let it run during transition)
    _controller.animateTo(
      targetRotation,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    // Pop immediately so rotation runs during page transition
    Navigator.of(context).pop(targetRotation);
    return false; // Prevent default pop since we're handling it manually
  }

  void _navigateToRegister() {
    final currentValue = _controller.value;
    Navigator.of(context).pushNamed(
      '/register',
      arguments: {
        'currentRotation': currentValue,
        'scaleBegin': 1.2,
      },
    );
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushNamed(
      '/onboarding',
      arguments: {
        'scaleBegin': 0.8,
        'onGetStarted': () {
          print('Get started pressed');
          // TODO: Navigate to main app
        },
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            GradientBackground(rotationAnimation: _controller),
            SafeArea(
              child: LoginContent(
                onLoginPressed: _navigateToOnboarding,
                onRegisterPressed: _navigateToRegister,
                goBack: _onWillPop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
