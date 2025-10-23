import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Camera access permission step
class CameraAccessStep extends StatelessWidget {
  const CameraAccessStep({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  Future<void> _requestCameraPermission() async {
    // TODO: Implement actual camera permission request
    // For now, just simulate a delay
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
              color: kSNDPigmentGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              size: 80,
              color: kSNDPigmentGreen,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'Camera Access',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            'We need access to your camera to capture treatment progress photos. This helps you track improvements over time.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Allow button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await _requestCameraPermission();
                onNext();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDPigmentGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text(
                'Allow Camera Access',
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
