import 'package:flutter/cupertino.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidPicker extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  final ValueChanged<int>? onSelected;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidPicker({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.onSelected,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidPickerState createState() => _LiquidPickerState();
}

class _LiquidPickerState extends State<LiquidPicker>
    with SingleTickerProviderStateMixin {
  late FixedExtentScrollController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      initialItem: widget.initialIndex.clamp(0, widget.items.length - 1),
    );
    if (widget.animate) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      );
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.animate) _animationController.dispose();
    super.dispose();
  }

  void _handleSelection(int index) {
    if (widget.animate) {
      _animationController.reset();
      _animationController.forward();
    }
    widget.onSelected?.call(index);
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
      child: SizedBox(
        height: 150.0,
        child: CupertinoPicker(
          scrollController: _controller,
          itemExtent: 32.0,
          onSelectedItemChanged: _handleSelection,
          children:
              widget.items
                  .map(
                    (item) => Center(child: Text(item, style: theme.textStyle)),
                  )
                  .toList(),
        ),
      ),
    );

    if (widget.animate) {
      content = LiquidTransition(animation: _animation, child: content);
    }

    return Semantics(label: widget.semanticsLabel ?? 'Picker', child: content);
  }
}
