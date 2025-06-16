import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidRadioState<T> createState() => _LiquidRadioState<T>();
}

class _LiquidRadioState<T> extends State<LiquidRadio<T>>
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

  void _handleChange() {
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
    widget.onChanged?.call(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: Radio<T>(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: null,
        //onChanged: widget.onChanged != null ? _handleChange : null,
        activeColor: theme.accentColor,
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Radio Button',
      checked: widget.value == widget.groupValue,
      enabled: widget.onChanged != null,
      child: content,
    );
  }
}
