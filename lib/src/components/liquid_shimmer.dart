import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidShimmer extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;
  final Duration duration;

  const LiquidShimmer({
    super.key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  _LiquidShimmerState createState() => _LiquidShimmerState();
}

class _LiquidShimmerState extends State<LiquidShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(duration: widget.duration, vsync: this)
        ..repeat();
      _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    }
  }

  @override
  void dispose() {
    if (widget.animate) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child:
          widget.child ??
          Container(
            width: double.infinity,
            height: 100.0,
            color: theme.primaryColor.withOpacity(0.5),
          ),
    );

    if (widget.animate) {
      content = AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  theme.primaryColor.withOpacity(0.5),
                  theme.accentColor.withOpacity(0.8),
                  theme.primaryColor.withOpacity(0.5),
                ],
                stops: [
                  _animation.value - 0.3,
                  _animation.value,
                  _animation.value + 0.3,
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: content,
          );
        },
      );
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Shimmer Loading',
      child: content,
    );
  }
}
