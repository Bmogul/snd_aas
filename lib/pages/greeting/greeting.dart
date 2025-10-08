import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/gradient_background.dart';
import 'package:snd_aas/pages/greeting/greeting_widgets.dart';

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
  ActivePageEnum? _previousPage;

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
      curve: Curves.bounceOut,
    );
    setState(() {
      _previousPage = activePage;
      activePage = ActivePageEnum.LOGIN;
    });

    print("Curret Page: $activePage");
  }

  void _playAnimationReverse() {
    final currentValue = _controller.value;
    _controller.animateTo(
      currentValue - 1.0,
      duration: const Duration(seconds: 2),
      curve: Curves.bounceOut,
    );
    setState(() {
      _previousPage = activePage;
      activePage = ActivePageEnum.REGISTER;
    });

    print("Curret Page: $activePage");
  }

  void backToGreeting() {
    final currentValue = _controller.value;
    // Determine rotation direction based on which page we're returning from
    if (_previousPage == null) {
      // If no previous page, just change state
      setState(() {
        _previousPage = activePage;
        activePage = ActivePageEnum.GREETING;
      });
      return;
    }

    if (activePage == ActivePageEnum.LOGIN) {
      // Coming back from login, rotate left (reverse)
      _controller.animateTo(
        currentValue - 1.0,
        duration: const Duration(seconds: 2),
        curve: Curves.bounceOut,
      );
    } else if (activePage == ActivePageEnum.REGISTER) {
      // Coming back from register, rotate right (forward)
      _controller.animateTo(
        currentValue + 1.0,
        duration: const Duration(seconds: 2),
        curve: Curves.bounceOut,
      );
    }

    setState(() {
      _previousPage = activePage;
      activePage = ActivePageEnum.GREETING;
    });
  }

  void goToOnboarding() {
    // Determine scale based on previous page
    double scaleBegin;
    if (_previousPage == ActivePageEnum.LOGIN) {
      // Standard zoom in from login
      scaleBegin = 0.8;
    } else if (_previousPage == ActivePageEnum.REGISTER) {
      // 2x zoom in from register
      scaleBegin = 0.6;
    } else {
      scaleBegin = 0.8;
    }

    // Navigate to onboarding page using named route
    Navigator.of(context).pushNamed(
      '/onboarding',
      arguments: {
        'scaleBegin': scaleBegin,
        'onGetStarted': () {
          print('Get started pressed');
          // TODO: Navigate to main app
        },
      },
    );
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
          onLoginPressed: () {
            setState(() {
              _previousPage = activePage;
            });
            goToOnboarding();
          },
          onRegisterPressed: _playAnimationReverse,
          goBack: backToGreeting,
        );
        break;
      case ActivePageEnum.REGISTER:
        activeWidget = RegisterContent(
          goBack: backToGreeting,
          onGooglePressed: () {
            setState(() {
              _previousPage = activePage;
            });
            goToOnboarding();
          },
          onApplePressed: () {
            setState(() {
              _previousPage = activePage;
            });
            goToOnboarding();
          },
        );
        break;
      default:
        activeWidget = NotFoundContent(goBack: backToGreeting);
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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                return Stack(
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Determine zoom direction based on page transition
                double scaleBegin;
                if (_previousPage == ActivePageEnum.GREETING && activePage == ActivePageEnum.LOGIN) {
                  // Zoom in when going from greeting to login
                  scaleBegin = 0.8;
                } else if (_previousPage == ActivePageEnum.GREETING && activePage == ActivePageEnum.REGISTER) {
                  // Zoom out when going from greeting to register
                  scaleBegin = 1.2;
                } else if (activePage == ActivePageEnum.GREETING && _previousPage == ActivePageEnum.LOGIN) {
                  // Zoom out when going back from login to greeting
                  scaleBegin = 1.2;
                } else if (activePage == ActivePageEnum.GREETING && _previousPage == ActivePageEnum.REGISTER) {
                  // Zoom in when going back from register to greeting
                  scaleBegin = 0.8;
                } else {
                  scaleBegin = 1.0;
                }

                final scaleAnimation = Tween<double>(
                  begin: scaleBegin,
                  end: 1.0,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ));

                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey<ActivePageEnum>(activePage),
                child: activeWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
