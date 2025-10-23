import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/features/auth/pages/greeting_page.dart';
import 'package:snd_aas/features/auth/pages/login_page.dart';
import 'package:snd_aas/features/auth/pages/register_page.dart';
import 'package:snd_aas/features/onboarding/pages/onboarding_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'greeting',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const GreetingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return CustomTransitionPage(
          key: state.pageKey,
          child: LoginPage(
            initialRotation: extra?['currentRotation'] ?? 0.0,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final scaleBegin = extra?['scaleBegin'] ?? 0.8;
            return _buildScaleFadeTransition(
              animation,
              child,
              scaleBegin,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return CustomTransitionPage(
          key: state.pageKey,
          child: RegisterPage(
            initialRotation: extra?['currentRotation'] ?? 0.0,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final scaleBegin = extra?['scaleBegin'] ?? 1.2;
            return _buildScaleFadeTransition(
              animation,
              child,
              scaleBegin,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return CustomTransitionPage(
          key: state.pageKey,
          child: OnboardingPage(
            onGetStarted: extra?['onGetStarted'] ??
                () => debugPrint('Get started pressed'),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final scaleBegin = extra?['scaleBegin'] ?? 0.8;
            return _buildScaleFadeTransition(
              animation,
              child,
              scaleBegin,
            );
          },
        );
      },
    ),
  ],
);

Widget _buildScaleFadeTransition(
  Animation<double> animation,
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
