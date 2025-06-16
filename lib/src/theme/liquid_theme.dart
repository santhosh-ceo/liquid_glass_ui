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
    this.primaryColor = const Color(0x00FFFFFF), // Fully transparent
    this.accentColor = const Color(0xFF4CAF50), // Green
    this.blurStrength = 25.0,
    this.borderRadius = 20.0,
    this.textStyle = const TextStyle(
      fontFamily: 'SFPro',
      color: Colors.black87,
      fontWeight: FontWeight.w500,
    ),
    this.defaultPadding = const EdgeInsets.all(12.0),
    this.defaultMargin = const EdgeInsets.all(8.0),
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
