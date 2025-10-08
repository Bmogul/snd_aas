import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_aas/pages/greeting/greeting.dart';
import 'package:snd_aas/pages/onboarding/onboarding.dart';
import 'package:snd_aas/providers/theme_provider.dart';

class SNDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'SND Anti-Aging System',
      initialRoute: '/',
      routes: {
        '/': (context) => const GreetingPage(),
        '/onboarding': (context) => OnboardingPage(
          onGetStarted: () {
            print('Get started pressed');
            // TODO: Navigate to main app
          },
        ),
      },
      theme: themeProvider.currentTheme,
      onGenerateRoute: (settings) {
        // Handle dynamic routes with arguments if needed
        if (settings.name == '/onboarding') {
          final args = settings.arguments as Map<String, dynamic>?;
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => OnboardingPage(
              onGetStarted: args?['onGetStarted'] ?? () {
                print('Get started pressed');
              },
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Get scale from arguments (0.8 for login, 0.6 for register)
              final scaleBegin = args?['scaleBegin'] ?? 0.8;

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
            },
            transitionDuration: const Duration(milliseconds: 500),
          );
        }
        return null;
      },
    );
  }
}
