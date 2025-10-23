import 'package:flutter/material.dart';

/// Responsive layout wrapper that handles landscape/portrait layouts
/// Consolidates layout logic from greeting_content.dart, login_content.dart, and register_content.dart
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.header,
    required this.content,
    this.spacing,
  }) : super(key: key);

  final Widget header;
  final Widget content;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth >= constraints.maxHeight;
        final effectiveSpacing = spacing ?? (isLandscape ? 0 : size.height * 0.1);

        return isLandscape
            ? Row(
                children: [
                  Expanded(child: Center(child: header)),
                  Expanded(child: Center(child: content)),
                ],
              )
            : Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      header,
                      SizedBox(height: effectiveSpacing),
                      content,
                    ],
                  ),
                ),
              );
      },
    );
  }
}

/// Helper extension to get responsive widths
extension ResponsiveContext on BuildContext {
  double responsiveWidth({double landscape = 0.3, double portrait = 0.7}) {
    final size = MediaQuery.of(this).size;
    final isLandscape = size.width >= size.height;
    return size.width * (isLandscape ? landscape : portrait);
  }

  bool get isLandscape {
    final size = MediaQuery.of(this).size;
    return size.width >= size.height;
  }
}
