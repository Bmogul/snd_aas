import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/shared/gradient_background.dart';

/// Base widget for pages with animated gradient background
/// Consolidates animation logic from login_page.dart and register_page.dart
class AnimatedPageBase extends StatefulWidget {
  const AnimatedPageBase({
    Key? key,
    required this.child,
    this.initialRotation = 0.0,
    this.rotationDirection = 1.0,
    this.showBackButton = false,
    this.onBackPressed,
  }) : super(key: key);

  final Widget child;
  final double initialRotation;
  final double rotationDirection; // 1.0 for right, -1.0 for left
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  State<AnimatedPageBase> createState() => AnimatedPageBaseState();
}

class AnimatedPageBaseState extends State<AnimatedPageBase>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
      value: widget.initialRotation,
    );

    // Animate in the direction specified
    _controller.animateTo(
      widget.initialRotation + widget.rotationDirection,
      duration: const Duration(seconds: 2),
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> handleBackNavigation() async {
    final currentValue = _controller.value;
    final targetRotation = currentValue - widget.rotationDirection;

    // Start rotation animation (don't await - let it run during transition)
    _controller.animateTo(
      targetRotation,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    return true;
  }

  double get currentRotation => _controller.value;

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      body: Stack(
        children: [
          GradientBackground(rotationAnimation: _controller),
          SafeArea(child: widget.child),
          if (widget.showBackButton)
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              ),
            ),
        ],
      ),
    );

    if (widget.showBackButton && widget.onBackPressed != null) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (!didPop) {
            await handleBackNavigation();
            if (context.mounted) {
              widget.onBackPressed!();
            }
          }
        },
        child: content,
      );
    }

    return content;
  }
}
