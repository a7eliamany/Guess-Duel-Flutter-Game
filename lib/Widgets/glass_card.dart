import 'dart:ui';
import 'package:flutter/material.dart';

/// Reusable glassmorphism card.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double blurSigma;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.blurSigma = 12,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor =
        backgroundColor ?? const Color(0xFF1C1B1B).withValues(alpha: 0.8);
    final border =
        borderColor ?? const Color(0xFF988CA2).withValues(alpha: 0.1);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: border),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
