import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key, required this.goBack}) : super(key: key);

  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: theme.colorScheme.error,
              ),
              SizedBox(height: 20),
              Text("404", style: theme.textTheme.displayLarge),
              SizedBox(height: 10),
              Text("Page Not Found", style: theme.textTheme.titleLarge),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: goBack,
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }
}
