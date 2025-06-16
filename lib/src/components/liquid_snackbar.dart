import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidSnackbar extends StatelessWidget {
  final String? message;
  final Duration duration;
  final Widget? action;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidSnackbar({
    super.key,
    this.message,
    this.duration = const Duration(seconds: 3),
    this.action,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  void show(BuildContext context) {
    final snackbar = _SnackbarContent(
      message: message,
      action: action,
      color: color,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      animate: animate,
      semanticsLabel: semanticsLabel,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: snackbar,
        duration: duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Snackbar is shown via show()
  }
}

class _SnackbarContent extends StatelessWidget {
  final String? message;
  final Widget? action;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const _SnackbarContent({
    this.message,
    this.action,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    required this.animate,
    this.semanticsLabel,
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
          Expanded(child: Text(message!, style: theme.textStyle)),
          if (action != null) action!,
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
      label: semanticsLabel ?? 'Snackbar $message',
      child: content,
    );
  }
}
