import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidProgress extends StatelessWidget {
  final double value;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? semanticsLabel;

  const LiquidProgress({
    super.key,
    required this.value,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
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
      label: semanticsLabel ?? 'Progress Indicator',
      value: '${(value.clamp(0.0, 1.0) * 100).toInt()}%',
      child: LiquidGlassEffect(
        borderRadius: borderRadius ?? theme.borderRadius,
        baseColor: color ?? theme.primaryColor,
        padding: padding ?? theme.defaultPadding,
        margin: margin ?? theme.defaultMargin,
        child: LinearProgressIndicator(
          value: value.clamp(0.0, 1.0),
          backgroundColor: theme.primaryColor.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation(theme.accentColor),
        ),
      ),
    );
  }
}
