import 'package:flutter/material.dart';

import '../effects/liquid_glass_effect.dart';
import '../theme/liquid_theme.dart';

class LiquidScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Color? backgroundColor;
  final String? semanticsLabel;

  const LiquidScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        context
            .dependOnInheritedWidgetOfExactType<LiquidThemeProvider>()
            ?.theme ??
        const LiquidTheme();

    return Semantics(
      label: semanticsLabel ?? 'Scaffold',
      child: Scaffold(
        backgroundColor: backgroundColor ?? theme.primaryColor.withOpacity(0.2),
        appBar:
            appBar != null
                ? PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: LiquidGlassEffect(child: appBar),
                )
                : null,
        body: body != null ? LiquidGlassEffect(child: body) : null,
        bottomNavigationBar:
            bottomNavigationBar != null
                ? LiquidGlassEffect(child: bottomNavigationBar)
                : null,
        floatingActionButton: floatingActionButton,
        drawer: drawer != null ? LiquidGlassEffect(child: drawer) : null,
      ),
    );
  }
}
