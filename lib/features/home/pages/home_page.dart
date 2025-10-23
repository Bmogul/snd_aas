import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/home/widgets/home_content.dart';

/// Home page with welcome message and treatment flow selection
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _onQuickTreatmentPressed(BuildContext context) {
    // TODO: Navigate to quick treatment flow
    debugPrint('Quick treatment selected');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quick Treatment flow coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onDeepTreatmentPressed(BuildContext context) {
    // TODO: Navigate to deep treatment flow
    debugPrint('Deep treatment selected');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deep Treatment flow coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2, // Home tab (middle position)
      child: SafeArea(
        child: HomeContent(
          onQuickTreatmentPressed: () => _onQuickTreatmentPressed(context),
          onDeepTreatmentPressed: () => _onDeepTreatmentPressed(context),
          userName: 'Alex', // TODO: Get from user state/provider
        ),
      ),
    );
  }
}
