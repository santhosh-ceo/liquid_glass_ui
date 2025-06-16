import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_ui_design/liquid_glass_ui.dart';

class LiquidGlassEffect extends StatelessWidget {
  final Widget? child;
  final double blurStrength;
  final Color? baseColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;

  const LiquidGlassEffect({
    super.key,
    this.child,
    this.blurStrength = 10.0,
    this.baseColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.borderWidth = 1.0,
    this.padding,
    this.margin,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()?.theme ?? const LiquidTheme();
    final bgColor = baseColor ?? theme.primaryColor.withOpacity(0.2); // Lighter tint for transparency
    final bColor = borderColor ?? theme.primaryColor.withOpacity(0.2); // Subtle border

    return Container(
      margin: margin ?? theme.defaultMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength * 1.5, sigmaY: blurStrength * 1.5), // Increased blur for glass effect
          child: Container(
            padding: padding ?? theme.defaultPadding,
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.5), // Reduced opacity for better transparency
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: bColor, width: borderWidth),
              gradient: LinearGradient(
                colors: [
                  bgColor.withOpacity(0.5), // Stronger top highlight
                  bgColor.withOpacity(0.1), // Deeper fade for shine
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: boxShadow ?? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Deeper shadow
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.3), // Stronger reflection
                  blurRadius: 8,
                  offset: const Offset(-3, -3),
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