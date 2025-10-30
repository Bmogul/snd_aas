import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/electric_stimulator/widgets/electric_stimulator_guide_content.dart';

/// Electric Stimulator guide page with information and routine selection
class ElectricStimulatorGuidePage extends StatelessWidget {
  const ElectricStimulatorGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2, // Home tab
      child: SafeArea(
        child: ElectricStimulatorGuideContent(),
      ),
    );
  }
}
