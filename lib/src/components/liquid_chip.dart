import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? avatar;
  final VoidCallback? onDeleted;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.avatar,
    this.onDeleted,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidChipState createState() => _LiquidChipState();
}

class _LiquidChipState extends State<LiquidChip>
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

  void _handleTap() {
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
    widget.onSelected?.call(!widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (widget.label.isEmpty) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor:
          widget.color ??
          (widget.selected
              ? theme.accentColor.withOpacity(0.3)
              : theme.primaryColor),
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: Chip(
        label: Text(widget.label, style: theme.textStyle),
        avatar: widget.avatar,
        deleteIcon:
            widget.onDeleted != null
                ? Icon(Icons.close, size: 18, color: theme.textStyle.color)
                : null,
        onDeleted: widget.onDeleted,
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Chip ${widget.label}',
      selected: widget.selected,
      child: GestureDetector(
        onTap: widget.onSelected != null ? _handleTap : null,
        child: content,
      ),
    );
  }
}
