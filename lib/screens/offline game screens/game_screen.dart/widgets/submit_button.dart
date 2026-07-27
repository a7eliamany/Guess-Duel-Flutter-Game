import 'package:flutter/material.dart';
import '../../../../theme/solo_challenge_theme.dart';

class SubmitButton extends StatefulWidget {
  final VoidCallback? onSubmitPressed;
  final String label;
  final bool isComplete;

  const SubmitButton({
    super.key,
    this.onSubmitPressed,
    this.label = 'SUBMIT',
    required this.isComplete,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isComplete ? widget.onSubmitPressed : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: widget.isComplete ? null : Colors.grey,
            gradient: widget.isComplete
                ? SoloChallengeTheme.submitButtonGradient
                : null,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              if (widget.isComplete)
                BoxShadow(
                  color: SoloChallengeTheme.primaryContainer.withValues(
                    alpha: 0.35,
                  ),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: SoloChallengeTheme.headlineStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: SoloChallengeTheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.sensors,
                color: SoloChallengeTheme.onPrimaryContainer,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
