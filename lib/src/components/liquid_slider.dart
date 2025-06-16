import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidSliderState createState() => _LiquidSliderState();
}

class _LiquidSliderState extends State<LiquidSlider>
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

  void _handleChange(double value) {
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (widget.min >= widget.max) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: Slider(
        value: widget.value.clamp(widget.min, widget.max),
        min: widget.min,
        max: widget.max,
        onChanged: widget.onChanged != null ? _handleChange : null,
        activeColor: theme.accentColor,
        inactiveColor: theme.primaryColor.withOpacity(0.5),
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Slider',
      value: widget.value.toString(),
      enabled: widget.onChanged != null,
      child: content,
    );
  }
}
