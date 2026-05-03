import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snd_aas/colors.dart';

/// Gallery access permission step
class GalleryAccessStep extends StatefulWidget {
  const GalleryAccessStep({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  State<GalleryAccessStep> createState() => _GalleryAccessStepState();
}

class _GalleryAccessStepState extends State<GalleryAccessStep> {
  bool _isRequesting = false;

  Future<void> _requestGalleryPermission() async {
    setState(() {
      _isRequesting = true;
    });

    try {
      // Request photos/gallery permission
      final photosStatus = await Permission.photos.request();

      if (photosStatus.isGranted) {
        // Permission granted, proceed
        widget.onNext();
      } else if (photosStatus.isPermanentlyDenied) {
        // Show dialog to open settings
        _showPermissionDeniedDialog(permanently: true);
      } else {
        // Permission denied but can be requested again
        // Gallery access is optional, so we can proceed
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
        title: const Text('Gallery Access'),
        content: Text(
          permanently
              ? 'To select photos from your gallery, please enable photo access in Settings.'
              : 'Gallery access allows you to select and view your treatment photos.',
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
              color: kSNDPigmentGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_library,
              size: 80,
              color: kSNDPigmentGreen,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'Gallery Access',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            'Access your photo gallery to view, select, and compare your treatment progress photos over time.',
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
              onPressed: _isRequesting ? null : _requestGalleryPermission,
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
                  : const Icon(Icons.photo_library),
              label: Text(
                _isRequesting ? 'Requesting...' : 'Allow Gallery Access',
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
