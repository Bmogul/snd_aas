import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Facial paralysis question step
class FacialParalysisStep extends StatelessWidget {
  const FacialParalysisStep({
    Key? key,
    required this.onAnswer,
  }) : super(key: key);

  final Function(bool) onAnswer;

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
              color: kSNDPigmentGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.face,
              size: 80,
              color: kSNDPigmentGreen,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'Medical History',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Question
          Text(
            'Do you currently experience facial paralysis or have a history of it?',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Additional info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kSNDCeladon.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: kSNDCeladon,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: kSNDJade,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This helps us customize treatments for your specific needs.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          // Yes button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => onAnswer(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDPigmentGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // No button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => onAnswer(false),
              style: OutlinedButton.styleFrom(
                foregroundColor: kSNDPigmentGreen,
                side: BorderSide(color: kSNDPigmentGreen, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
