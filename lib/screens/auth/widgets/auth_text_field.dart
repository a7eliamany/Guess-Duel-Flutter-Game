import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable modern dark auth text field matching the exact design specs
/// (rounded-xl, #0C101C background, #1F283D border, cyan focus ring, custom prefix & suffix).
class AuthTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final Widget prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _internalFocusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    } else {
      _internalFocusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final borderColor = hasError
        ? const Color(0xFFFF4D4D)
        : _isFocused
            ? const Color(0xFF00F0FF)
            : const Color(0xFF1F283D);

    final iconColor = hasError
        ? const Color(0xFFFF6B6B)
        : _isFocused
            ? const Color(0xFF00F0FF)
            : const Color(0xFF64748B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Field Label
        Text(
          widget.label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: const Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 6),

        // Input Field Container
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: const Color(0xFF0C101C),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: _isFocused || hasError ? 1.5 : 1.0,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: const Color(0xFF00F0FF).withValues(alpha: 0.18),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _internalFocusNode,
            obscureText: widget.isPassword ? widget.obscureText : false,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            cursorColor: const Color(0xFF00F0FF),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFE2E8F0),
              letterSpacing: widget.isPassword && widget.obscureText ? 2.5 : 0.2,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
                letterSpacing: 0.2,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 42,
                minHeight: 42,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: IconTheme(
                  data: IconThemeData(
                    color: iconColor,
                    size: 18,
                  ),
                  child: widget.prefixIcon,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                        color: const Color(0xFF64748B),
                      ),
                      onPressed: widget.onToggleObscure,
                      splashRadius: 18,
                      tooltip: widget.obscureText ? 'Show password' : 'Hide password',
                    )
                  : null,
            ),
          ),
        ),

        // Error message if any
        if (hasError) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.errorText!,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF6B6B),
              ),
            ),
          ).animate().fadeIn(duration: 200.ms).slideY(begin: -0.2, end: 0),
        ],
      ],
    );
  }
}
