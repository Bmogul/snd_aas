import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/features/auth/pages/greeting_page.dart';
import 'package:snd_aas/features/auth/pages/login_page.dart';
import 'package:snd_aas/features/auth/pages/register_page.dart';
import 'package:snd_aas/features/onboarding/pages/onboarding_page.dart';
import 'package:snd_aas/features/home/pages/home_page.dart';
import 'package:snd_aas/features/progress/pages/progress_page.dart';
import 'package:snd_aas/features/notifications/pages/notifications_page.dart';
import 'package:snd_aas/features/settings/pages/settings_page.dart';
import 'package:snd_aas/features/profile/pages/profile_page.dart';

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
    // Main app routes
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/progress',
      name: 'progress',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProgressPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const NotificationsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
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
