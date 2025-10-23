import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Calendar sync step
class CalendarSyncStep extends StatelessWidget {
  const CalendarSyncStep({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  final VoidCallback onNext;
  final VoidCallback onSkip;

  Future<void> _syncCalendar() async {
    // TODO: Implement actual calendar sync
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
              color: kSNDYellowGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_today,
              size: 80,
              color: kSNDYellowGreen,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'Sync Your Calendar',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            'Sync your calendar to schedule treatment sessions and set reminders. Never miss a session!',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Sync button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await _syncCalendar();
                onNext();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDYellowGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.sync),
              label: const Text(
                'Sync Calendar',
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
