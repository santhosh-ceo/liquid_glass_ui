import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_ui_design/liquid_glass_ui.dart';

class LiquidGlassEffect extends StatelessWidget {
  final Widget? child;
  final double blurStrength;
  final Color? baseColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double vibrancy;
  final List<BoxShadow>? boxShadow;
  final double surfaceOpacity;
  final double reflectionIntensity;

  const LiquidGlassEffect({
    super.key,
    this.child,
    this.blurStrength = 30.0,
    this.baseColor,
    this.borderColor,
    this.borderRadius = 20.0,
    this.borderWidth = 0.5,
    this.padding,
    this.margin,
    this.vibrancy = 0.7,
    this.boxShadow,
    this.surfaceOpacity = 0.08,
    this.reflectionIntensity = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseColorValue = baseColor ?? Colors.white;
    final double effectiveVibrancy = vibrancy.clamp(0.0, 1.0);

    return Container(
      margin: margin ?? const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurStrength,
            sigmaY: blurStrength,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: boxShadow ?? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: -5,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Base glass surface with subtle gradient
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: RadialGradient(
                      center: const Alignment(-0.3, -0.5),
                      radius: 1.2,
                      colors: [
                        baseColorValue.withOpacity(surfaceOpacity * 0.8),
                        baseColorValue.withOpacity(surfaceOpacity * 1.2),
                        baseColorValue.withOpacity(surfaceOpacity * 0.6),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),

                // Main reflection layer - creates the liquid shine effect
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: LinearGradient(
                      begin: const Alignment(-0.8, -0.8),
                      end: const Alignment(0.8, 0.8),
                      colors: [
                        Colors.white.withOpacity(reflectionIntensity * 0.8),
                        Colors.white.withOpacity(reflectionIntensity * 0.2),
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(reflectionIntensity * 0.1),
                        Colors.white.withOpacity(0.0),
                      ],
                      stops: const [0.0, 0.15, 0.35, 0.7, 1.0],
                    ),
                  ),
                ),

                // Secondary shine - creates depth and liquid movement
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: LinearGradient(
                      begin: const Alignment(-0.5, -1.0),
                      end: const Alignment(0.5, 0.2),
                      colors: [
                        Colors.white.withOpacity(reflectionIntensity * 0.6),
                        Colors.white.withOpacity(reflectionIntensity * 0.1),
                        Colors.white.withOpacity(0.0),
                      ],
                      stops: const [0.0, 0.25, 0.6],
                    ),
                  ),
                ),

                // Edge highlights - simulates glass refraction
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      gradient: LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, 1.0),
                        colors: [
                          Colors.white.withOpacity(reflectionIntensity * 0.7),
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(reflectionIntensity * 0.3),
                        ],
                        stops: const [0.0, 0.03, 0.97, 1.0],
                      ),
                    ),
                  ),
                ),

                // Left edge highlight
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      gradient: LinearGradient(
                        begin: const Alignment(-1.0, 0.0),
                        end: const Alignment(1.0, 0.0),
                        colors: [
                          Colors.white.withOpacity(reflectionIntensity * 0.5),
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(reflectionIntensity * 0.2),
                        ],
                        stops: const [0.0, 0.02, 0.98, 1.0],
                      ),
                    ),
                  ),
                ),

                // Noise/texture overlay for realistic glass surface
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: LinearGradient(
                      begin: const Alignment(-1.0, -1.0),
                      end: const Alignment(1.0, 1.0),
                      colors: [
                        Colors.white.withOpacity(0.03),
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.02),
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.01),
                      ],
                      stops: const [0.0, 0.2, 0.4, 0.6, 1.0],
                    ),
                  ),
                ),

                // Border with gradient for depth
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      width: borderWidth,
                      color: Colors.transparent,
                    ),
                    gradient: LinearGradient(
                      begin: const Alignment(-0.5, -0.5),
                      end: const Alignment(0.5, 0.5),
                      colors: [
                        (borderColor ?? Colors.white).withOpacity(0.4),
                        (borderColor ?? Colors.white).withOpacity(0.1),
                        (borderColor ?? Colors.white).withOpacity(0.2),
                        (borderColor ?? Colors.white).withOpacity(0.05),
                      ],
                    ),
                  ),
                ),

                // Inner border for extra depth
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.all(borderWidth),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius - borderWidth),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),

                // Content container
                Padding(
                  padding: padding ?? const EdgeInsets.all(24.0),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}