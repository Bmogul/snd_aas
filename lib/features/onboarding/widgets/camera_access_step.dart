import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snd_aas/colors.dart';

/// Camera access permission step
class CameraAccessStep extends StatefulWidget {
  const CameraAccessStep({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  State<CameraAccessStep> createState() => _CameraAccessStepState();
}

class _CameraAccessStepState extends State<CameraAccessStep> {
  bool _isRequesting = false;

  Future<void> _requestCameraPermission() async {
    setState(() {
      _isRequesting = true;
    });

    try {
      // Request camera permission
      final cameraStatus = await Permission.camera.request();

      // Request photos permission (for accessing gallery and saving photos)
      final photosStatus = await Permission.photos.request();

      if (cameraStatus.isGranted && photosStatus.isGranted) {
        // Both permissions granted, proceed
        widget.onNext();
      } else if (cameraStatus.isPermanentlyDenied || photosStatus.isPermanentlyDenied) {
        // Show dialog to open settings
        _showPermissionDeniedDialog(permanently: true);
      } else {
        // Permissions denied but can be requested again
        _showPermissionDeniedDialog(permanently: false);
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
        title: const Text('Camera Access Required'),
        content: Text(
          permanently
              ? 'Camera and photo access are required to track your treatment progress. Please enable them in Settings.'
              : 'Camera and photo access are needed to capture and view your treatment progress photos.',
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
            },
            child: Text(permanently ? 'Cancel' : 'OK'),
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
            'We need access to your camera to create treatment maps and capture treatment progress photos. This helps you track improvements over time.',
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
              onPressed: _isRequesting ? null : _requestCameraPermission,
              style: ElevatedButton.styleFrom(
                backgroundColor: kSNDPigmentGreen,
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
                  : const Icon(Icons.check_circle_outline),
              label: Text(
                _isRequesting ? 'Requesting...' : 'Allow Camera Access',
                style: const TextStyle(
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
