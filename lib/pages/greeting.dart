import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/gradient_background.dart';
import 'package:snd_aas/widgets/greeting_content.dart';
import 'package:snd_aas/widgets/login_content.dart';
import 'package:snd_aas/widgets/not_found_page.dart';

enum ActivePageEnum { GREETING, LOGIN, REGISTER }

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GreetingPageState();
  }
}

class _GreetingPageState extends State<GreetingPage>
    with TickerProviderStateMixin {
  ActivePageEnum activePage = ActivePageEnum.GREETING;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    lowerBound: double.negativeInfinity,
    upperBound: double.infinity,
    value: 0.0,
  );

  void _playAnimationForward() {
    final currentValue = _controller.value;
    _controller.animateTo(
      currentValue + 1.0,
      duration: const Duration(seconds: 2),
    );
    setState(() {
      activePage = ActivePageEnum.LOGIN;
    });

    print("Curret Page: $activePage");
  }

  void _playAnimationReverse() {
    final currentValue = _controller.value;
    _controller.animateTo(
      currentValue - 1.0,
      duration: const Duration(seconds: 2),
    );
    setState(() {
      activePage = ActivePageEnum.REGISTER;
    });

    print("Curret Page: $activePage");
  }

  void backToGreeting() {
    setState(() {
      activePage = ActivePageEnum.GREETING;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget;

    switch (activePage) {
      case ActivePageEnum.GREETING:
        activeWidget = GreetingContent(
          onLoginPressed: _playAnimationForward,
          onRegisterPressed: _playAnimationReverse,
        );
        break;
      case ActivePageEnum.LOGIN:
        activeWidget = LoginContent(
          onLoginPressed: _playAnimationForward,
          onRegisterPressed: _playAnimationReverse,
        );
        break;
      default:
        activeWidget = NotFoundPage(goBack: backToGreeting);
    }

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

    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 1 * 3.141592,
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
                );
              },
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return activeWidget;
              },
            ),
          ),
        ],
      ),
    );
  }
}
