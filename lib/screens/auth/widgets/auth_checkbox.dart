import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom styled checkbox matching the HTML specification
/// (18x18, #0E121D background, #28334E border, #00F0FF checked state with dark checkmark)
/// and rich text links for Terms & Privacy Policy.
class AuthCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyPolicyTap;

  const AuthCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.onTermsTap,
    this.onPrivacyPolicyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Interactive Custom Checkbox Box
          GestureDetector(
            onTap: () => onChanged(!isChecked),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: isChecked ? const Color(0xFF00F0FF) : const Color(0xFF0E121D),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isChecked ? const Color(0xFF00F0FF) : const Color(0xFF28334E),
                  width: 1.5,
                ),
                boxShadow: isChecked
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00F0FF).withValues(alpha: 0.35),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: isChecked
                  ? const Center(
                      child: Icon(
                        Icons.check_rounded,
                        size: 13,
                        color: Color(0xFF0A0E19),
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 10),

          // Label with Clickable Links
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'I agree to the ',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: 'Terms',
                    style: const TextStyle(
                      color: Color(0xFF00F0FF),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF00F0FF),
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                  ),
                  const TextSpan(
                    text: ' & ',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      color: Color(0xFF00F0FF),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF00F0FF),
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
