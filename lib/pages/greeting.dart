import 'package:flutter/material.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GreetingPageState();
  }
}

class _GreetingPageState extends State<GreetingPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20),
                        Text("SND ", style: theme.textTheme.displayMedium),
                        Text(
                          "Anti-Aging System",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: size.height * .1),
                        SizedBox(
                          width: size.width * .5,

                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Login"),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: size.width * .5,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text("Register Product"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
