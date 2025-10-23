import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/widgets/shared/gradient_background.dart';
import 'package:snd_aas/features/onboarding/widgets/camera_access_step.dart';
import 'package:snd_aas/features/onboarding/widgets/calendar_sync_step.dart';
import 'package:snd_aas/features/onboarding/widgets/reminders_step.dart';
import 'package:snd_aas/features/onboarding/widgets/facial_paralysis_step.dart';
import 'package:snd_aas/features/onboarding/widgets/first_selfie_step.dart';
import 'package:snd_aas/features/onboarding/widgets/ready_step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key, this.onGetStarted}) : super(key: key);

  final VoidCallback? onGetStarted;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleComplete(BuildContext context) {
    if (widget.onGetStarted != null) {
      widget.onGetStarted!();
    }
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          SafeArea(
            child: Column(
              children: [
                // Page content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      CameraAccessStep(onNext: _nextPage),
                      CalendarSyncStep(onNext: _nextPage, onSkip: _nextPage),
                      RemindersStep(onNext: _nextPage, onSkip: _nextPage),
                      FacialParalysisStep(
                        onAnswer: (hasParalysis) {
                          // TODO: Store hasParalysis in user state/preferences
                          _nextPage();
                        },
                      ),
                      FirstSelfieStep(onNext: _nextPage, onSkip: _nextPage),
                      ReadyStep(onComplete: () => _handleComplete(context)),
                    ],
                  ),
                ),
                // Progress indicator (dots)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: index == _currentPage ? 12 : 8,
                        height: index == _currentPage ? 12 : 8,
                        decoration: BoxDecoration(
                          color: index == _currentPage
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                // Navigation buttons
                if (_currentPage > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextButton.icon(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
