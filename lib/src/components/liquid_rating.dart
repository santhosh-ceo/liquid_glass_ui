import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidRating extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final int itemCount;
  final double itemSize;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidRating({
    super.key,
    required this.value,
    this.onChanged,
    this.itemCount = 5,
    this.itemSize = 24.0,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidRatingState createState() => _LiquidRatingState();
}

class _LiquidRatingState extends State<LiquidRating>
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

  void _handleRating(double value) {
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

    if (widget.itemCount <= 0) {
      return const SizedBox.shrink();
    }

    Widget content = LiquidGlassEffect(
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      baseColor: widget.color ?? theme.primaryColor,
      padding: widget.padding ?? theme.defaultPadding,
      margin: widget.margin ?? theme.defaultMargin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.itemCount, (index) {
          final isSelected = index < widget.value.floor();
          final partial =
              index == widget.value.floor() ? widget.value - index : 0.0;
          return GestureDetector(
            onTap:
                widget.onChanged != null
                    ? () => _handleRating(index + 1.0)
                    : null,
            child: Stack(
              children: [
                Icon(
                  Icons.star_border,
                  size: widget.itemSize,
                  color: theme.textStyle.color?.withOpacity(0.5),
                ),
                if (isSelected || partial > 0)
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: isSelected ? 1.0 : partial,
                      child: Icon(
                        Icons.star,
                        size: widget.itemSize,
                        color: theme.accentColor,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Rating ${widget.value}',
      value: widget.value.toString(),
      enabled: widget.onChanged != null,
      child: content,
    );
  }
}
