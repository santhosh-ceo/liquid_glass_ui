import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidCard extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final String? semanticsLabel;

  const LiquidCard({
    super.key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation = 4.0,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    return Semantics(
      label: semanticsLabel ?? 'Card',
      child: LiquidGlassEffect(
        borderRadius: borderRadius ?? theme.borderRadius,
        baseColor: color ?? theme.primaryColor,
        padding: padding ?? theme.defaultPadding,
        margin: margin ?? theme.defaultMargin,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation ?? 4.0,
            offset: const Offset(0, 2),
          ),
        ],
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
