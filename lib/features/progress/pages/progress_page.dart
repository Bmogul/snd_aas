import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/progress/widgets/progress_content.dart';

/// Progress/Calendar page for tracking treatment history
class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 1, // Progress tab (second position)
      child: const SafeArea(
        child: ProgressContent(),
      ),
    );
  }
}
