import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snd_aas/colors.dart';

/// Reminders setup step
class RemindersStep extends StatefulWidget {
  const RemindersStep({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  State<RemindersStep> createState() => _RemindersStepState();
}

class _RemindersStepState extends State<RemindersStep> {
  bool _isRequesting = false;

  Future<void> _enableReminders() async {
    setState(() {
      _isRequesting = true;
    });

    try {
      // Request notification permission
      final status = await Permission.notification.request();

      if (status.isGranted) {
        // Permission granted, proceed
        widget.onNext();
      } else if (status.isPermanentlyDenied) {
        // Show dialog to open settings
        _showPermissionDeniedDialog(permanently: true);
      } else {
        // Permission denied but can be requested again
        // For notifications, we can still proceed as it's optional
        widget.onNext();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRequesting = false;
        });
      }
    }
  }

  void _showPermissionDeniedDialog({required bool permanently}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Permission'),
        content: Text(
          permanently
              ? 'To receive treatment reminders, please enable notifications in Settings.'
              : 'Notifications help you stay consistent with your treatment schedule.',
        ),
        actions: [
          if (permanently)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onNext();
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
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
              onPressed: _isRequesting ? null : _enableReminders,
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDJade,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: _isRequesting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.notifications),
              label: Text(
                _isRequesting ? 'Requesting...' : 'Enable Reminders',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Skip button
          TextButton(
            onPressed: _isRequesting ? null : widget.onSkip,
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
