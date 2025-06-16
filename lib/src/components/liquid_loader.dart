import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidLoader extends StatelessWidget {
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;
  final double size;

  const LiquidLoader({
    super.key,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    Widget content = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding: padding ?? theme.defaultPadding,
      margin: margin ?? theme.defaultMargin,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: theme.accentColor,
          strokeWidth: 4.0,
        ),
      ),
    );

    if (animate) {
      content = LiquidTransition(
        animation: CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: Navigator.of(context),
          )..forward(),
          curve: Curves.easeInOut,
        ),
        child: content,
      );
    }

    return Semantics(
      label: semanticsLabel ?? 'Loading Spinner',
      child: content,
    );
  }
}
