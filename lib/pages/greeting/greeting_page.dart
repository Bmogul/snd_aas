import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/gradient_background.dart';
import 'package:snd_aas/pages/greeting/greeting_content.dart';

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

  Future<void> _navigateWithRotation(String route, double scaleBegin) async {
    final currentValue = _controller.value;
    await Navigator.of(context).pushNamed(
      route,
      arguments: {
        'currentRotation': currentValue,
        'scaleBegin': scaleBegin,
      },
    );

    // When returning, animate back to original rotation
    _controller.animateTo(
      currentValue,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() => _navigateWithRotation('/login', 0.8);

  void _navigateToRegister() => _navigateWithRotation('/register', 1.2);

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
