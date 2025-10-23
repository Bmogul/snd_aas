import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/shared/responsive_layout.dart';
import 'package:snd_aas/widgets/shared/form_fields.dart';

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
    return ResponsiveLayout(
      header: HeaderSection(
        title: "SND",
        subtitle: "Anti-Aging System",
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ResponsiveButton(
            onPressed: onLoginPressed,
            label: "Login",
          ),
          SizedBox(height: 10),
          ResponsiveOutlinedButton(
            onPressed: onRegisterPressed,
            label: "Register Product",
          ),
        ],
      ),
    );
  }
}
