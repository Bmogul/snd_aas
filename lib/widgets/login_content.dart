import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
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
                Text("Welcome Back ", style: theme.textTheme.displayMedium),
                Text("Choose login method", style: theme.textTheme.titleMedium),
                SizedBox(height: size.height * .1),
                SizedBox(
                  width: size.width * .5,
                  child: OutlinedButton.icon(
                    onPressed: onLoginPressed,
                    icon: FaIcon(FontAwesomeIcons.google, size: 20),
                    label: Text("Continue with Google"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: theme.colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: size.width * .5,
                  child: ElevatedButton.icon(
                    onPressed: onRegisterPressed,
                    icon: FaIcon(FontAwesomeIcons.apple, size: 20),
                    label: Text("Continue with Apple"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
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
