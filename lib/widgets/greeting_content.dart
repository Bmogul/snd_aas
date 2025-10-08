import 'package:flutter/material.dart';

class GreetingContent extends StatelessWidget {
  const GreetingContent({
    Key? key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  }) : super(key: key);

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset('assets/logo.png', height: 80, fit: BoxFit.cover),
                SizedBox(height: 20),
                Text("SND ", style: theme.textTheme.displayMedium),
                Text("Anti-Aging System", style: theme.textTheme.titleMedium),
                SizedBox(height: size.height * .1),
                SizedBox(
                  width: size.width * .5,
                  child: ElevatedButton(
                    onPressed: onLoginPressed,
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: size.width * .5,
                  child: OutlinedButton(
                    onPressed: onRegisterPressed,
                    child: Text("Register Product"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
