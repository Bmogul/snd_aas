import 'package:flutter/material.dart';

/// Reusable card for treatment flow options
class TreatmentFlowCard extends StatelessWidget {
  const TreatmentFlowCard({
    Key? key,
    required this.title,
    required this.description,
    this.icon,
    this.imagePath,
    required this.accentColor,
    required this.onTap,
  }) : assert(icon != null || imagePath != null, 'Either icon or imagePath must be provided'),
       super(key: key);

  final String title;
  final String description;
  final IconData? icon;
  final String? imagePath;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shadowColor: accentColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: accentColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                accentColor.withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imagePath != null
                    ? Image.asset(
                        imagePath!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                    : Icon(
                        icon,
                        size: 40,
                        color: accentColor,
                      ),
              ),
              const SizedBox(height: 16),
              // Text section
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Arrow icon
              Icon(
                Icons.arrow_forward,
                color: accentColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
