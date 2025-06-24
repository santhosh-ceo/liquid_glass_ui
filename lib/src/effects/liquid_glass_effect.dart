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
    this.blurStrength = 25.0,
    this.baseColor,
    this.highlightColor,
    this.reflectionColor,
    this.borderColor,
    this.borderRadius = 20.0,
    this.borderWidth = 0.8,
    this.padding,
    this.margin,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.vibrancy = 0.4,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    final baseColorValue = baseColor ?? Colors.white;
    final bgAlpha = (255 * vibrancy).round().clamp(0, 255);
    final glassColor = baseColorValue.withAlpha(bgAlpha);

    return Container(
      margin: margin ?? theme.defaultMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: AnimatedContainer(
            duration: animate ? animationDuration : Duration.zero,
            padding: padding ?? theme.defaultPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: glassColor.withOpacity(0.1), // Transparent white
              border: Border.all(
                color: borderColor ?? Colors.white.withOpacity(0.2),
                width: borderWidth,
              ),
              boxShadow:
                  boxShadow ??
                  [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(-2, -2),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 14,
                      offset: const Offset(2, 2),
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
