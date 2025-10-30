import 'package:flutter/material.dart';
import 'package:snd_aas/layouts/main_layout.dart';
import 'package:snd_aas/features/introduction/widgets/introduction_content.dart';

/// Introduction page with instructional YouTube video
class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2, // Home tab
      child: SafeArea(
        child: IntroductionContent(),
      ),
    );
  }
}
