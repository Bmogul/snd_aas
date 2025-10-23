import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/home/widgets/home_content.dart';

/// Home page with welcome message and treatment flow selection
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _onGuaShaPressed(BuildContext context) {
    // TODO: Navigate to Gua Sha treatment flow
    debugPrint('Gua Sha treatment selected');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gua Sha treatment flow coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onElectricStimulatorPressed(BuildContext context) {
    // TODO: Navigate to Electric Stimulator treatment flow
    debugPrint('Electric Stimulator treatment selected');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Electric Stimulator flow coming soon!'),
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
          onGuaShaPressed: () => _onGuaShaPressed(context),
          onElectricStimulatorPressed: () => _onElectricStimulatorPressed(context),
          userName: 'Alex', // TODO: Get from user state/provider
        ),
      ),
    );
  }
}
