import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final ValueChanged<String>? onChanged;
  final String? semanticsLabel;

  const LiquidTextField({
    super.key,
    this.controller,
    this.prefix,
    this.suffix,
    this.hintText,
    this.hintStyle,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onChanged,
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
      label: semanticsLabel ?? 'Text Field',
      child: LiquidGlassEffect(
        borderRadius: borderRadius ?? theme.borderRadius,
        baseColor: color ?? theme.primaryColor,
        padding: padding ?? theme.defaultPadding,
        margin: margin ?? theme.defaultMargin,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: theme.textStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle:
                hintStyle ??
                theme.textStyle.copyWith(
                  color: theme.textStyle.color?.withOpacity(0.5),
                ),
            prefixIcon: prefix,
            suffixIcon: suffix,
          ),
        ),
      ),
    );
  }
}
