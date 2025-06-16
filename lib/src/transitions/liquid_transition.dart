import 'package:flutter/material.dart';

class LiquidTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget? child;
  final bool scale;
  final bool fade;

  const LiquidTransition({
    super.key,
    required this.animation,
    this.child,
    this.scale = true,
    this.fade = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = child ?? const SizedBox.shrink();
    if (fade) {
      result = FadeTransition(opacity: animation, child: result);
    }
    if (scale) {
      result = ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
        child: result,
      );
    }
    return result;
  }
}
