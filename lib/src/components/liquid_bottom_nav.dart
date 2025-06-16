import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidBottomNav extends StatefulWidget {
  final List<IconData> icons;
  final ValueChanged<int>? onItemSelected;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate;
  final String? semanticsLabel;

  const LiquidBottomNav({
    super.key,
    required this.icons,
    this.onItemSelected,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.animate = true,
    this.semanticsLabel,
  });

  @override
  _LiquidBottomNavState createState() => _LiquidBottomNavState();
}

class _LiquidBottomNavState extends State<LiquidBottomNav>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
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

  void _onItemTap(int index) {
    if (index >= 0 && index < widget.icons.length) {
      setState(() {
        _selectedIndex = index;
        if (widget.animate) {
          _controller.reset();
          _controller.forward();
        }
      });
      widget.onItemSelected?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (widget.icons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: widget.semanticsLabel ?? 'Bottom Navigation Bar',
      child: LiquidGlassEffect(
        borderRadius: widget.borderRadius ?? theme.borderRadius,
        baseColor: widget.color ?? theme.primaryColor,
        padding: widget.padding ?? theme.defaultPadding,
        margin: widget.margin ?? theme.defaultMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.icons.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTap(index),
              child: Semantics(
                label: 'Navigation Item ${index + 1}',
                selected: isSelected,
                child: LiquidTransition(
                  animation: _animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      widget.icons[index],
                      color:
                          isSelected
                              ? theme.accentColor
                              : theme.textStyle.color,
                      size: 28.0,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
