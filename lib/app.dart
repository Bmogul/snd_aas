import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_aas/providers/theme_provider.dart';
import 'package:snd_aas/router.dart';

class SNDApp extends StatelessWidget {
  const SNDApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      title: 'SND Anti-Aging System',
      theme: themeProvider.currentTheme,
      routerConfig: router,
    );
  }
}
