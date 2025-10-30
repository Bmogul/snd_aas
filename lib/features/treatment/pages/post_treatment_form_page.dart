import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/treatment/widgets/post_treatment_form_content.dart';

/// Post-treatment form page for capturing progress photos and notes
class PostTreatmentFormPage extends StatelessWidget {
  const PostTreatmentFormPage({
    Key? key,
    required this.treatmentName,
    required this.treatmentIcon,
    required this.accentColor,
  }) : super(key: key);

  final String treatmentName;
  final String treatmentIcon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2, // Home tab
      child: SafeArea(
        child: PostTreatmentFormContent(
          treatmentName: treatmentName,
          treatmentIcon: treatmentIcon,
          accentColor: accentColor,
        ),
      ),
    );
  }
}
