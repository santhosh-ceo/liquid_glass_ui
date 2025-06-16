import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidAccordion extends StatelessWidget {
  final String title;
  final Widget? content;
  final bool expanded;
  final ValueChanged<bool>? onChanged;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidAccordion({
    super.key,
    required this.title,
    this.content,
    this.expanded = false,
    this.onChanged,
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

    Widget accordion = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding: padding ?? theme.defaultPadding,
      margin: margin ?? theme.defaultMargin,
      child: ExpansionTile(
        title: Text(title, style: theme.textStyle),
        initiallyExpanded: expanded,
        onExpansionChanged: onChanged,
        children: content != null ? [content!] : [],
      ),
    );

    if (animate) {
      accordion = LiquidTransition(
        animation: CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: Navigator.of(context),
          )..forward(),
          curve: Curves.easeInOut,
        ),
        child: accordion,
      );
    }

    return Semantics(
      label: semanticsLabel ?? 'Accordion $title',
      expanded: expanded,
      child: accordion,
    );
  }
}
