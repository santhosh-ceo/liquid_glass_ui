import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidFlushbar extends StatelessWidget {
  final String? message;
  final Duration duration;
  final Widget? icon;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;
  final VoidCallback? onTap;

  const LiquidFlushbar({
    super.key,
    this.message,
    this.duration = const Duration(seconds: 3),
    this.icon,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
    this.onTap,
  });

  void show(BuildContext context) {
    final flushbar = _FlushbarContent(
      message: message,
      duration: duration,
      icon: icon,
      color: color,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      animate: animate,
      semanticsLabel: semanticsLabel,
      onTap: onTap,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: flushbar,
        duration: duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Flushbar is shown via show()
  }
}

class _FlushbarContent extends StatelessWidget {
  final String? message;
  final Duration duration;
  final Widget? icon;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;
  final VoidCallback? onTap;

  const _FlushbarContent({
    this.message,
    required this.duration,
    this.icon,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    required this.animate,
    this.semanticsLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (message == null || message!.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: borderRadius ?? theme.borderRadius,
      baseColor: color ?? theme.primaryColor,
      padding: padding ?? theme.defaultPadding,
      margin: margin ?? theme.defaultMargin,
      child: Row(
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 8)],
          Expanded(child: Text(message!, style: theme.textStyle)),
        ],
      ),
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
      label: semanticsLabel ?? 'Notification $message',
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}
