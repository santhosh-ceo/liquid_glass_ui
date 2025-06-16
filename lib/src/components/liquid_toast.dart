import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidToast extends StatelessWidget {
  final String? message;
  final Duration duration;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidToast({
    super.key,
    this.message,
    this.duration = const Duration(seconds: 2),
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  void show(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: 50.0,
            left: 16.0,
            right: 16.0,
            child: _ToastContent(
              message: message,
              color: color,
              borderRadius: borderRadius,
              padding: padding,
              margin: margin,
              animate: animate,
              semanticsLabel: semanticsLabel,
            ),
          ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Toast is shown via show()
  }
}

class _ToastContent extends StatelessWidget {
  final String? message;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const _ToastContent({
    this.message,
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
      child: Text(message!, style: theme.textStyle),
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

    return Semantics(label: semanticsLabel ?? 'Toast $message', child: content);
  }
}
