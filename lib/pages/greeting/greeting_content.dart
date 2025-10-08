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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth >= constraints.maxHeight;

        final headerSection = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 80, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text("SND ", style: theme.textTheme.displayMedium),
            Text("Anti-Aging System", style: theme.textTheme.titleMedium),
          ],
        );

        final actionSection = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isLandscape ? size.width * .3 : size.width * .5,
              child: ElevatedButton(
                onPressed: onLoginPressed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Login"),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: isLandscape ? size.width * .3 : size.width * .5,
              child: OutlinedButton(
                onPressed: onRegisterPressed,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Register Product"),
              ),
            ),
          ],
        );

        return isLandscape
            ? Row(
                children: [
                  Expanded(
                    child: Center(child: headerSection),
                  ),
                  Expanded(
                    child: Center(child: actionSection),
                  ),
                ],
              )
            : Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerSection,
                      SizedBox(height: size.height * .1),
                      actionSection,
                    ],
                  ),
                ),
              );
      },
    );
  }
}
