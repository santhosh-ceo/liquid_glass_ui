import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_ui_design/liquid_glass_ui.dart';

class LiquidGlassEffect extends StatelessWidget {
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
    this.blurStrength = 10.0, // Matches GlassContainer default
    this.baseColor,
    this.highlightColor,
    this.reflectionColor,
    this.borderColor,
    this.borderRadius = 12.0, // Matches GlassContainer default
    this.borderWidth = 1.0, // Matches GlassContainer default
    this.padding,
    this.margin,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.vibrancy = 0.5, // Adjusted for transparency
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()?.theme ?? const LiquidTheme();
    final bgColor = baseColor ?? theme.primaryColor.withOpacity(0.2); // Lighter tint like GlassContainer
    final bColor = borderColor ?? theme.primaryColor.withOpacity(0.3); // Subtle border like GlassContainer

    return Container(
      margin: margin ?? theme.defaultMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength), // Matches GlassContainer blur
          child: Container(
            padding: padding ?? theme.defaultPadding,
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.2), // Reduced opacity for transparency
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: bColor, width: borderWidth),
              boxShadow: boxShadow ?? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Deeper shadow for depth
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.2), // Added reflection for shine
                  blurRadius: 6,
                  offset: const Offset(-2, -2),
                ),
              ],
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}