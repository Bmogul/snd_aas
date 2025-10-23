import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Reminders setup step
class RemindersStep extends StatelessWidget {
  const RemindersStep({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  final VoidCallback onNext;
  final VoidCallback onSkip;

  Future<void> _enableReminders() async {
    // TODO: Implement actual notification permissions request
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Icon
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kSNDCeladon.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active,
              size: 80,
              color: kSNDJade,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'Treatment Reminders',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            'Get reminders for your treatment sessions to stay consistent and achieve better results.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Enable button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await _enableReminders();
                onNext();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDJade,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.notifications),
              label: const Text(
                'Enable Reminders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Skip button
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip for now',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
