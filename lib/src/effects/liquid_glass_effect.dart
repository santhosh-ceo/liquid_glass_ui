import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

class LiquidGlassEffect extends StatefulWidget {
  final Widget? child;
  final double blurStrength;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? reflectionColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final Duration animationDuration;
  final double vibrancy;
  final List<BoxShadow>? boxShadow;

  const LiquidGlassEffect({
    super.key,
    this.child,
    this.blurStrength = 40.0, // Matched to reference blur
    this.baseColor,
    this.highlightColor,
    this.reflectionColor,
    this.borderColor,
    this.borderRadius = 24.0, // Matched to reference radius
    this.borderWidth = 2.0, // Thicker border for definition
    this.padding,
    this.margin,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 3000), // Slower for fluid motion
    this.vibrancy = 0.85, // Higher vibrancy for shine
    this.boxShadow,
  });

  @override
  _LiquidGlassEffectState createState() => _LiquidGlassEffectState();
}

class _LiquidGlassEffectState extends State<LiquidGlassEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      )..repeat(reverse: true);
      _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    }
  }

  @override
  void dispose() {
    if (widget.animate) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()?.theme ?? const LiquidTheme();
    final baseColor = widget.baseColor ?? Colors.white.withOpacity(widget.vibrancy);
    final highlightColor = widget.highlightColor ?? Colors.orange.withOpacity(0.6); // Warm tone from screenshot
    final reflectionColor = widget.reflectionColor ?? Colors.white.withOpacity(0.4); // Stronger reflection
    final borderColor = widget.borderColor ?? Colors.white.withOpacity(0.3); // Slightly stronger border

    return Container(
      margin: widget.margin ?? theme.defaultMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Stack(
          children: [
            // Enhanced background blur
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.blurStrength,
                sigmaY: widget.blurStrength,
                tileMode: TileMode.mirror,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            // Dynamic gradient with reflection
            AnimatedBuilder(
              animation: widget.animate ? _animation : const AlwaysStoppedAnimation(0.0),
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0.3 + _animation.value * 0.4, -0.3 - _animation.value * 0.4),
                      radius: 1.8, // Slightly larger radius for wider spread
                      colors: [
                        baseColor.withOpacity(0.8 + _animation.value * 0.1),
                        highlightColor.withOpacity(0.7 - _animation.value * 0.2),
                        baseColor.withOpacity(0.6 + _animation.value * 0.1),
                      ],
                      stops: [0.0, 0.65 + _animation.value * 0.2, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(color: borderColor, width: widget.borderWidth),
                    boxShadow: widget.boxShadow ?? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 8), // Deeper shadow for 3D
                      ),
                      // Enhanced specular reflection
                      BoxShadow(
                        color: reflectionColor.withOpacity(0.3 + _animation.value * 0.2),
                        blurRadius: 6,
                        spreadRadius: 0,
                        offset: const Offset(-6, -6),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Content layer
            Container(
              padding: widget.padding ?? theme.defaultPadding,
              child: widget.child ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}