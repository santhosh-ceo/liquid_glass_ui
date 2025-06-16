import 'package:flutter/material.dart';

class LiquidTheme {
  final Color primaryColor;
  final Color accentColor;
  final double blurStrength;
  final double borderRadius;
  final TextStyle textStyle;
  final EdgeInsets defaultPadding;
  final EdgeInsets defaultMargin;

  const LiquidTheme({
    this.primaryColor = const Color(0x90FFFFFF), // Vibrant base
    this.accentColor = const Color(0xFFFF9500), // Warm orange
    this.blurStrength = 40.0, // Match reference blur
    this.borderRadius = 24.0, // Smoother corners
    this.textStyle = const TextStyle(
      fontFamily: 'SFPro',
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    this.defaultPadding = const EdgeInsets.all(12.0),
    this.defaultMargin = const EdgeInsets.all(4.0),
  });

  ThemeData toThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        bodyMedium: textStyle,
        labelLarge: textStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class LiquidThemeProvider extends InheritedWidget {
  final LiquidTheme theme;

  const LiquidThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  static LiquidThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LiquidThemeProvider>();
  }

  @override
  bool updateShouldNotify(LiquidThemeProvider oldWidget) =>
      theme != oldWidget.theme;
}
