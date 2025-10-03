import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_aas/pages/greeting.dart';
import 'package:snd_aas/providers/theme_provider.dart';

class SNDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    // TODO: implement build
    return MaterialApp(
      title: 'SND Anti-Aging System',
      initialRoute: '/',
      routes: {'/': (BuildContext context) => const GreetingPage()},
      theme: themeProvider.currentTheme
    );
  }
}
