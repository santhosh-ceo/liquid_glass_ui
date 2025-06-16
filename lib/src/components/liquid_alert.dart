import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidAlert extends StatelessWidget {
  final String? title;
  final String? content;
  final List<Widget>? actions;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidAlert({
    super.key,
    this.title,
    this.content,
    this.actions,
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

    Widget dialog = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding: padding ?? theme.defaultPadding,
      margin: margin ?? theme.defaultMargin,
      child: AlertDialog(
        title: title != null ? Text(title!, style: theme.textStyle) : null,
        content:
            content != null ? Text(content!, style: theme.textStyle) : null,
        actions:
            actions ??
            [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: theme.textStyle),
              ),
            ],
      ),
    );

    if (animate) {
      dialog = LiquidTransition(
        animation: CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: Navigator.of(context),
          )..forward(),
          curve: Curves.easeInOut,
        ),
        child: dialog,
      );
    }

    return Semantics(label: semanticsLabel ?? 'Alert Dialog', child: dialog);
  }
}
