import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidBadge extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidBadge({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (text == null && child == null) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: margin ?? theme.defaultMargin,
      child:
          child ?? Text(text!, style: theme.textStyle.copyWith(fontSize: 12)),
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
      label: semanticsLabel ?? 'Badge ${text ?? ''}',
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}
