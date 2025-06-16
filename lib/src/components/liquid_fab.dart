import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidFAB extends StatefulWidget {
  final Widget? icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidFAB({
    super.key,
    this.icon,
    this.onPressed,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidFABState createState() => _LiquidFABState();
}

class _LiquidFABState extends State<LiquidFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
      _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.animate) _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? 100.0,
      // Circular by default
      baseColor: widget.color ?? theme.accentColor,
      padding: widget.padding ?? const EdgeInsets.all(16),
      margin: widget.margin ?? theme.defaultMargin,
      child: FloatingActionButton(
        onPressed: widget.onPressed != null ? _handlePress : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: widget.icon ?? Icon(Icons.add, color: theme.textStyle.color),
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Floating Action Button',
      enabled: widget.onPressed != null,
      child: content,
    );
  }
}
