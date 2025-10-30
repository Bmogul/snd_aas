import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/gua_sha/widgets/gua_sha_guide_content.dart';

/// Gua Sha guide page with information and start button
class GuaShaGuidePage extends StatelessWidget {
  const GuaShaGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2, // Home tab
      child: SafeArea(
        child: GuaShaGuideContent(),
      ),
    );
  }
}
