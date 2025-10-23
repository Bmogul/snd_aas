import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_aas/app.dart';
import 'package:snd_aas/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: SNDApp(),
    ),
  );
}
