import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidDropdown<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidDropdown({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidDropdownState<T> createState() => _LiquidDropdownState<T>();
}

class _LiquidDropdownState<T> extends State<LiquidDropdown<T>>
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

  void _handleChange(T? value) {
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

    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: DropdownButton<T>(
        value: widget.value,
        items: widget.items,
        onChanged: widget.onChanged != null ? _handleChange : null,
        hint:
            widget.hint != null
                ? Text(widget.hint!, style: theme.textStyle)
                : null,
        isExpanded: true,
        style: theme.textStyle,
        dropdownColor: theme.primaryColor.withOpacity(0.8),
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Dropdown Menu',
      value: widget.value?.toString(),
      enabled: widget.onChanged != null,
      child: content,
    );
  }
}
