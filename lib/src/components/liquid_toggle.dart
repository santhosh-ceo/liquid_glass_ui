import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidToggle extends StatefulWidget {
  final List<String> options;
  final List<int> selectedIndices;
  final ValueChanged<List<int>>? onChanged;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidToggle({
    super.key,
    required this.options,
    this.selectedIndices = const [],
    this.onChanged,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidToggleState createState() => _LiquidToggleState();
}

class _LiquidToggleState extends State<LiquidToggle>
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

  void _handleToggle(int index) {
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
    final newIndices = List<int>.from(widget.selectedIndices);
    if (newIndices.contains(index)) {
      newIndices.remove(index);
    } else {
      newIndices.add(index);
    }
    widget.onChanged?.call(newIndices);
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (widget.options.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: ToggleButtons(
        isSelected: List.generate(
          widget.options.length,
          (index) => widget.selectedIndices.contains(index),
        ),
        onPressed: widget.onChanged != null ? _handleToggle : null,
        color: theme.textStyle.color,
        selectedColor: theme.accentColor,
        fillColor: theme.accentColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(theme.borderRadius),
        children:
            widget.options
                .map(
                  (option) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(option, style: theme.textStyle),
                  ),
                )
                .toList(),
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Toggle Buttons',
      child: content,
    );
  }
}
