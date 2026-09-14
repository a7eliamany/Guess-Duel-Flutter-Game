import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Renders the divider and social login buttons (Google & Facebook)
/// matching the exact design and SVG vectors from the reference HTML.
class SocialAuthButtons extends StatelessWidget {
  final String dividerText;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;
  final VoidCallback? onGuestTap;
  final String? guestButtonText;

  const SocialAuthButtons({
    super.key,
    this.dividerText = 'OR SIGN UP WITH',
    this.onGoogleTap,
    this.onFacebookTap,
    this.onGuestTap,
    this.guestButtonText,
  });

  static const String _googleSvg = '''
<svg viewBox="0 0 24 24">
  <path d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.665-5.17 3.665-9.17z" fill="#4285F4"/>
  <path d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.25v3.15C3.26 21.36 7.36 24 12 24z" fill="#34A853"/>
  <path d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.25C.45 8.18 0 10.03 0 12s.45 3.82 1.25 5.42l4.03-3.15z" fill="#FBBC05"/>
  <path d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.36 0 3.26 2.64 1.25 6.58l4.03 3.15c.95-2.83 3.6-4.98 6.72-4.98z" fill="#EA4335"/>
</svg>
''';

  static const String _facebookSvg = '''
<svg viewBox="0 0 24 24" fill="#1877F2">
  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Divider
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  color: Color(0xFF1F273C),
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  dividerText,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  color: Color(0xFF1F273C),
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),

        // Social Buttons Row
        Row(
          children: [
            Expanded(
              child: _SocialItemButton(
                icon: SvgPicture.string(_googleSvg, width: 16, height: 16),
                label: 'Google',
                onTap: onGoogleTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SocialItemButton(
                icon: SvgPicture.string(_facebookSvg, width: 16, height: 16),
                label: 'Facebook',
                onTap: onFacebookTap,
              ),
            ),
          ],
        ),

        // Optional Instant Play as Guest Button
        if (onGuestTap != null) ...[
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 14),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0x991E293B),
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: _GuestPlayButton(
                onTap: onGuestTap!,
                text: guestButtonText ?? 'Play Instant as Guest',
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _GuestPlayButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;

  const _GuestPlayButton({required this.onTap, required this.text});

  @override
  State<_GuestPlayButton> createState() => _GuestPlayButtonState();
}

class _GuestPlayButtonState extends State<_GuestPlayButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sports_esports_outlined,
                size: 18,
                color: _isPressed
                    ? const Color(0xFF67E8F9)
                    : const Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _isPressed
                      ? const Color(0xFF67E8F9)
                      : const Color(0xFF94A3B8),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _SocialItemButton extends StatefulWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  const _SocialItemButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  State<_SocialItemButton> createState() => _SocialItemButtonState();
}

class _SocialItemButtonState extends State<_SocialItemButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0D111C),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF1F283C),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
