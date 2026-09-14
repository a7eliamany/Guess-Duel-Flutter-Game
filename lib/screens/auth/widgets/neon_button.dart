import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Primary neon glowing button with active tactile scaling and loading state support.
class NeonButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const NeonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.height = 52,
    this.backgroundColor = const Color(0xFF00F0FF),
    this.textColor = const Color(0xFF0A0E19),
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool canPress = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: canPress ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: canPress ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: canPress ? () => setState(() => _isPressed = false) : null,
      onTap: canPress ? widget.onPressed : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(
                  alpha: _isPressed ? 0.25 : 0.45,
                ),
                blurRadius: 24,
                spreadRadius: -2,
                offset: Offset.zero,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: widget.textColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (widget.icon != null) ...[
                      const SizedBox(width: 8),
                      widget.icon!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
