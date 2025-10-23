import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_aas/pages/greeting/greeting_page.dart';
import 'package:snd_aas/pages/greeting/login_page.dart';
import 'package:snd_aas/pages/greeting/register_page.dart';
import 'package:snd_aas/pages/onboarding/onboarding.dart';
import 'package:snd_aas/providers/theme_provider.dart';

class SNDApp extends StatelessWidget {
  // Shared transition builder to eliminate code duplication
  Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    double scaleBegin,
  ) {
    final scaleTween = Tween<double>(
      begin: scaleBegin,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final fadeTween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    return FadeTransition(
      opacity: fadeTween,
      child: ScaleTransition(
        scale: scaleTween,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'SND Anti-Aging System',
      initialRoute: '/',
      theme: themeProvider.currentTheme,
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => const GreetingPage(),
            );

          case '/login':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => LoginPage(
                initialRotation: args?['currentRotation'] ?? 0.0,
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                  _buildTransition(context, animation, secondaryAnimation, child, args?['scaleBegin'] ?? 0.8),
              transitionDuration: const Duration(milliseconds: 500),
            );

          case '/register':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(
                initialRotation: args?['currentRotation'] ?? 0.0,
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                  _buildTransition(context, animation, secondaryAnimation, child, args?['scaleBegin'] ?? 1.2),
              transitionDuration: const Duration(milliseconds: 500),
            );

          case '/onboarding':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => OnboardingPage(
                onGetStarted: args?['onGetStarted'] ?? () => print('Get started pressed'),
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                  _buildTransition(context, animation, secondaryAnimation, child, args?['scaleBegin'] ?? 0.8),
              transitionDuration: const Duration(milliseconds: 500),
            );
        }
        return null;
      },
    );
  }
}
