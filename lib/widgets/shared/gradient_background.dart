import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
    this.rotationAnimation,
  }) : super(key: key);

  final Animation<double>? rotationAnimation;

  Widget _buildFloatingCircle(
    BuildContext context,
    double size,
    Color color,
    AlignmentGeometry alignment,
  ) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xFFd6e8b7),
                Color(0xFFd3e8ac),
              ],
            ),
          ),
        ),
        // Rotating circles (optional)
        if (rotationAnimation != null)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: rotationAnimation!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotationAnimation!.value * 1 * 3.141592,
                  child: Stack(
                    children: [
                      _buildFloatingCircle(
                        context,
                        75,
                        theme.colorScheme.tertiary,
                        Alignment(-.5, .5),
                      ),
                      _buildFloatingCircle(
                        context,
                        250,
                        theme.colorScheme.secondary,
                        Alignment(-1.8, 1.1),
                      ),
                      _buildFloatingCircle(
                        context,
                        50,
                        theme.colorScheme.primary,
                        Alignment(-.8, -.6),
                      ),
                      _buildFloatingCircle(
                        context,
                        300,
                        theme.colorScheme.tertiary,
                        Alignment(3.0, -1.2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
