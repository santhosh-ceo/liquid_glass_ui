import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidAvatar extends StatelessWidget {
  final ImageProvider? image;
  final double radius;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? semanticsLabel;

  const LiquidAvatar({
    super.key,
    this.image,
    this.radius = 40.0,
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

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundImage: image,
      backgroundColor: theme.primaryColor.withOpacity(0.5),
    );

    return Semantics(
      label: semanticsLabel ?? 'Avatar',
      child: LiquidGlassEffect(
        borderRadius: borderRadius ?? radius,
        baseColor: color ?? theme.primaryColor,
        padding: padding ?? theme.defaultPadding,
        margin: margin ?? theme.defaultMargin,
        child: ClipOval(child: avatar),
      ),
    );
  }
}
