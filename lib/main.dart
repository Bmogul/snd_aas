import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    var titlestyle = theme.textTheme.titleLarge!.copyWith(fontSize: 35);

    return Scaffold(
      appBar: AppBar(title: const Text("SND")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main title section with logo, app title and tagline
            Image.asset('assets/logo.png', height: 250, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text("SND Anti Aging System", style: titlestyle),
            Text("Rejuvenate naturally, every day"),

            // Action center for creating account or registering a new product
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Login")),

                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Register Product"),
                  ),

                  Text('Let\'s begin your journey to radiant health'),
                ],
              ),
            ),

            // bottom tagline
          ],
        ),
      ),
    );
  }
}
