import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInputCard extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const PasswordInputCard({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<PasswordInputCard> createState() => _PasswordInputCardState();
}

class _PasswordInputCardState extends State<PasswordInputCard> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            "PASSWORD",
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF849396),
              letterSpacing: 1.2,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: const Color(0xFF353534),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isFocused
                  ? const Color(0xFFC3F5FF).withValues(alpha: 0.4)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.vpn_key_outlined,
                color: _isFocused
                    ? const Color(0xFFC3F5FF)
                    : const Color(0xFF849396),
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: _obscureText,
                  onChanged: widget.onChanged,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFE5E2E1),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter room password...",
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF849396).withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: _isFocused
                      ? const Color(0xFFE5E2E1)
                      : const Color(0xFF849396),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}
