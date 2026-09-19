import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String username) onSignIn;

  const SignInForm({
    super.key,
    required this.isLoading,
    required this.onSignIn,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _showErrorBorder = false;
  bool _isButtonPressed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  bool validator(String text) {
    if (text.isEmpty) {
      setState(() {
        _showErrorBorder = true;
      });
      _nameFocusNode.requestFocus();
      Get.snackbar("Error", "Please enter a name first");
      return false;
    } else if (text.length > 15) {
      setState(() {
        _showErrorBorder = true;
      });
      _nameFocusNode.requestFocus();
      Get.snackbar("Error", "username must be shorter than 15 charcters");
      return false;
    } else if (text.length < 2) {
      setState(() {
        _showErrorBorder = true;
      });
      _nameFocusNode.requestFocus();
      Get.snackbar("Error", "username must be at least 2 charcters");
      return false;
    } else {
      return true;
    }
  }

  void _handleGetStarted() {
    final String text = _nameController.text.trim();
    if (validator(text)) {
      setState(() {
        _showErrorBorder = false;
      });
      widget.onSignIn(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Username Form Label
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              "YOUR NAME",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE5E2E1),
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        // Text Field Container
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1B1B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _showErrorBorder
                  ? const Color(0xFFFFB4AB)
                  : const Color(0xFF3B494C),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Color(0xFF849396)),
              hintText: "Enter your name",
              hintStyle: GoogleFonts.inter(color: const Color(0xFF849396)),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              if (_showErrorBorder && text.trim().isNotEmpty) {
                setState(() {
                  _showErrorBorder = false;
                });
              }
            },
          ),
        ),
        const SizedBox(height: 24),
        // Get Started Button
        GestureDetector(
          onTapDown: (_) => setState(() => _isButtonPressed = true),
          onTapUp: (_) => setState(() => _isButtonPressed = false),
          onTapCancel: () => setState(() => _isButtonPressed = false),
          onTap: widget.isLoading ? null : _handleGetStarted,
          child: Transform.scale(
            scale: _isButtonPressed ? 0.96 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF00E5FF,
                    ).withValues(alpha: _isButtonPressed ? 0.2 : 0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: widget.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
