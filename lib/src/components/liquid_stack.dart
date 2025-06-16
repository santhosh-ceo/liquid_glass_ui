import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidStack extends StatelessWidget {
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidStack({
    super.key,
    required this.children,
    this.alignment = Alignment.center,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding: padding ?? theme.defaultPadding,
      margin: margin ?? theme.defaultMargin,
      child: Stack(alignment: alignment, children: children),
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

    return Semantics(label: semanticsLabel ?? 'Stack', child: content);
  }
}
