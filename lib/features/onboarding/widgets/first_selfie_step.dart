import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// First selfie capture step
class FirstSelfieStep extends StatefulWidget {
  const FirstSelfieStep({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  State<FirstSelfieStep> createState() => _FirstSelfieStepState();
}

class _FirstSelfieStepState extends State<FirstSelfieStep> {
  bool _photoTaken = false;

  Future<void> _takeSelfie() async {
    // TODO: Implement actual camera functionality
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _photoTaken = true;
    });
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
              _photoTaken ? Icons.check_circle : Icons.camera_front,
              size: 80,
              color: kSNDYellowGreen,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'Track Your Progress',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            _photoTaken
                ? 'Great! Your baseline photo is saved. You can compare future progress photos with this one.'
                : 'Take your first selfie to establish a baseline. You\'ll be able to see your progress over time.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Tips
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: kSNDJade,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Tips for a good photo:',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kSNDJade,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTip('Good lighting'),
                _buildTip('Neutral expression'),
                _buildTip('Face the camera directly'),
              ],
            ),
          ),
          const SizedBox(height: 48),
          // Take photo or continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _photoTaken
                  ? widget.onNext
                  : () async {
                      await _takeSelfie();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDYellowGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(_photoTaken ? Icons.arrow_forward : Icons.camera_alt),
              label: Text(
                _photoTaken ? 'Continue' : 'Take Selfie',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (!_photoTaken) ...[
            const SizedBox(height: 16),
            // Skip button
            TextButton(
              onPressed: widget.onSkip,
              child: Text(
                'Skip for now',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, bottom: 4),
      child: Row(
        children: [
          Icon(
            Icons.check,
            size: 16,
            color: kSNDJade.withOpacity(0.7),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
