import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidExpansion extends StatelessWidget {
  final String title;
  final Widget? content;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidExpansion({
    super.key,
    required this.title,
    this.content,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
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

    if (title.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget panel = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding: padding ?? theme.defaultPadding,
      margin: margin ?? theme.defaultMargin,
      child: ExpansionTile(
        title: Text(title, style: theme.textStyle),
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: onExpansionChanged,
        children: content != null ? [content!] : [],
      ),
    );

    if (animate) {
      panel = LiquidTransition(
        animation: CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: Navigator.of(context),
          )..forward(),
          curve: Curves.easeInOut,
        ),
        child: panel,
      );
    }

    return Semantics(
      label: semanticsLabel ?? 'Expansion Panel $title',
      expanded: initiallyExpanded,
      child: panel,
    );
  }
}
