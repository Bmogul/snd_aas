import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/home/widgets/home_content.dart';

/// Home page with welcome message and treatment flow selection
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _onGuaShaPressed(BuildContext context) {
    context.push('/gua-sha-guide');
  }

  void _onElectricStimulatorPressed(BuildContext context) {
    context.push('/electric-stimulator-guide');
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
