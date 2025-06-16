import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? semanticsLabel;
  final TextAlign? textAlign;

  const LiquidText({
    super.key,
    this.text,
    this.style,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.semanticsLabel,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (text == null || text!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: semanticsLabel ?? text,
      child: LiquidGlassEffect(
        borderRadius: borderRadius ?? theme.borderRadius,
        baseColor: color ?? theme.primaryColor,
        padding: padding ?? theme.defaultPadding,
        margin: margin ?? theme.defaultMargin,
        child: Text(
          text!,
          style: style ?? theme.textStyle,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
