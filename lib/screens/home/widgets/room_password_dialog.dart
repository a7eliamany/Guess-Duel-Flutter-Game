import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/scale_on_press_button.dart';
import 'package:guess_duel/screens/create_game/create_game_bottomsheet.dart';

/// A custom password input dialog/bottom sheet styled identically to
/// [CreateGameBottomsheet] with a modern, dark gaming aesthetic.
class RoomPasswordDialog extends StatefulWidget {
  /// The correct password for local verification (optional).
  final String? expectedPassword;

  /// Optional room code or name to display in subtitle.
  final String? roomCode;

  /// Callback invoked when password validation succeeds or is submitted.
  /// Return a completed Future to automatically close the dialog.
  final Future<void> Function(String password)? onSubmitted;

  /// Synchronous callback on successful entry.
  final ValueChanged<String>? onSuccess;

  const RoomPasswordDialog({
    super.key,
    this.expectedPassword,
    this.roomCode,
    this.onSubmitted,
    this.onSuccess,
  });

  /// Displays the password input screen as a BottomSheet.
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    String? expectedPassword,
    String? roomCode,
    Future<void> Function(String password)? onSubmitted,
    ValueChanged<String>? onSuccess,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (ctx) => RoomPasswordDialog(
        expectedPassword: expectedPassword,
        roomCode: roomCode,
        onSubmitted: onSubmitted,
        onSuccess: onSuccess,
      ),
    );
  }

  /// Displays the password input screen as a centered Dialog.
  static Future<T?> showDialogWindow<T>(
    BuildContext context, {
    String? expectedPassword,
    String? roomCode,
    Future<void> Function(String password)? onSubmitted,
    ValueChanged<String>? onSuccess,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF131313),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFF3B494C).withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            child: RoomPasswordDialogContent(
              expectedPassword: expectedPassword,
              roomCode: roomCode,
              onSubmitted: onSubmitted,
              onSuccess: onSuccess,
              isDialogMode: true,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<RoomPasswordDialog> createState() => _RoomPasswordDialogState();
}

class _RoomPasswordDialogState extends State<RoomPasswordDialog> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Bottom Sheet Drag Handle
            Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFBAC9CC).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF131313),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border.all(
                  color: const Color(0xFF3B494C).withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
              child: RoomPasswordDialogContent(
                expectedPassword: widget.expectedPassword,
                roomCode: widget.roomCode,
                onSubmitted: widget.onSubmitted,
                onSuccess: widget.onSuccess,
                isDialogMode: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The inner content widget handling state, validation, animations, and user interaction.
class RoomPasswordDialogContent extends StatefulWidget {
  final String? expectedPassword;
  final String? roomCode;
  final Future<void> Function(String password)? onSubmitted;
  final ValueChanged<String>? onSuccess;
  final bool isDialogMode;

  const RoomPasswordDialogContent({
    super.key,
    this.expectedPassword,
    this.roomCode,
    this.onSubmitted,
    this.onSuccess,
    this.isDialogMode = false,
  });

  @override
  State<RoomPasswordDialogContent> createState() =>
      _RoomPasswordDialogContentState();
}

class _RoomPasswordDialogContentState extends State<RoomPasswordDialogContent> {
  late final TextEditingController _passwordController;

  bool _obscureText = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final password = _passwordController.text.trim();

    if (password.isEmpty) {
      setState(() {
        _errorMessage = "Please enter the room password";
      });
      return;
    }

    if (widget.expectedPassword != null &&
        password != widget.expectedPassword) {
      setState(() {
        _errorMessage = "Incorrect password. Please try again.";
      });
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      if (widget.onSubmitted != null) {
        await widget.onSubmitted!(password);
      }
      if (widget.onSuccess != null) {
        widget.onSuccess!(password);
      }
      if (mounted) {
        Navigator.of(context).pop(password);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll("Exception: ", "");
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header Row with Lock Badge Icon & Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Private Room",
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE5E2E1),
                      height: 1.1,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.roomCode != null
                        ? "Enter password to join room #${widget.roomCode}"
                        : "This room is protected. Enter the password to join.",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: const Color(0xFFBAC9CC),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Glowing Lock Badge Icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFC3F5FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFC3F5FF).withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC3F5FF).withValues(alpha: 0.08),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFFC3F5FF),
                size: 26,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Password Input Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
              child: Text(
                "ROOM PASSWORD",
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
                  color: _errorMessage != null
                      ? const Color(0xFFFFB4AB).withValues(alpha: 0.8)
                      : Colors.transparent,
                  width: _errorMessage != null ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.vpn_key_outlined,
                    color: _errorMessage != null
                        ? const Color(0xFFFFB4AB)
                        : const Color(0xFF849396),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _passwordController,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      obscureText: _obscureText,
                      enabled: !_isLoading,
                      autofocus: true,
                      onChanged: (_) {
                        if (_errorMessage != null) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                      },
                      onSubmitted: (_) => _handleSubmit(),
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
                      color: const Color(0xFF849396),
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
            // Inline Error Banner
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _errorMessage != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            size: 16,
                            color: Color(0xFFFFB4AB),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: const Color(0xFFFFB4AB),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Action Buttons
        MyAnimatedButton(
          isLoading: _isLoading,
          color: const Color(0xFFC3F5FF),
          iconData: Icons.login_rounded,
          text: "JOIN ROOM",
          onPressed: _handleSubmit,
        ),

        const SizedBox(height: 16),

        // Cancel Button
        GestureDetector(
          onTap: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text(
              "CANCEL",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF849396),
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
