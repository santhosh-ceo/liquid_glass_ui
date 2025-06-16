import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';
import '../transitions/liquid_transition.dart';

class LiquidTabs extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTabSelected;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const LiquidTabs({
    super.key,
    required this.tabs,
    this.onTabSelected,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  _LiquidTabsState createState() => _LiquidTabsState();
}

class _LiquidTabsState extends State<LiquidTabs>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    if (index >= 0 && index < widget.tabs.length) {
      setState(() {
        _selectedIndex = index;
        _controller.reset();
        _controller.forward();
      });
      widget.onTabSelected?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    if (widget.tabs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: 'Tab Bar',
      child: LiquidGlassEffect(
        borderRadius: widget.borderRadius ?? theme.borderRadius,
        baseColor: widget.color ?? theme.primaryColor,
        padding: widget.padding ?? theme.defaultPadding,
        margin: widget.margin ?? theme.defaultMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.tabs.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onTabTap(index),
              child: Semantics(
                label: 'Tab ${widget.tabs[index]}',
                selected: isSelected,
                child: LiquidTransition(
                  animation: _animation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? theme.accentColor.withOpacity(0.3)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(theme.borderRadius),
                    ),
                    child: Text(
                      widget.tabs[index],
                      style: theme.textStyle.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
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
