import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidSegment<T> extends StatefulWidget {
  final List<T> values;
  final T? selectedValue;
  final ValueChanged<T>? onChanged;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidSegment({
    super.key,
    required this.values,
    this.selectedValue,
    this.onChanged,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidSegmentState<T> createState() => _LiquidSegmentState<T>();
}

class _LiquidSegmentState<T> extends State<LiquidSegment<T>>
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

  void _handleChange(T value) {
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

    if (widget.values.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: SegmentedButton<T>(
        segments:
            widget.values
                .map(
                  (value) => ButtonSegment<T>(
                    value: value,
                    label: Text(value.toString(), style: theme.textStyle),
                  ),
                )
                .toList(),
        selected: widget.selectedValue != null ? {widget.selectedValue!} : {},
        onSelectionChanged:
            widget.onChanged != null
                ? (selected) => _handleChange(selected.first)
                : null,
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Segmented Control',
      value: widget.selectedValue?.toString(),
      enabled: widget.onChanged != null,
      child: content,
    );
  }
}
