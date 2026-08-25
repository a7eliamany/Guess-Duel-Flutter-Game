import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAnimatedButton extends StatelessWidget {
  final bool isLoading;
  final Color color;
  final IconData iconData;
  final String text;
  final void Function()? onPressed;
  const MyAnimatedButton({
    super.key,
    required this.isLoading,
    required this.color,
    required this.iconData,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleOnPressButton(
      onPressed: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00363D),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(iconData, color: const Color(0xFF00363D), size: 22),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF00363D),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ScaleOnPressButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const ScaleOnPressButton({
    super.key,
    required this.onPressed,
    required this.child,
  });
  @override
  State<ScaleOnPressButton> createState() => _ScaleOnPressButtonState();
}

class _ScaleOnPressButtonState extends State<ScaleOnPressButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: enabled ? () => setState(() => _isPressed = false) : null,
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        await Future.delayed(100.milliseconds);
        setState(() {
          _isPressed = false;
        });
        widget.onPressed?.call();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}
