import 'package:flutter/material.dart';
import '../theme/solo_challenge_theme.dart';

class Keypad extends StatelessWidget {
  final ValueChanged<String>? onNumberPressed;
  final VoidCallback? onBackspacePressed;

  const Keypad({super.key, this.onNumberPressed, this.onBackspacePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 380),
      child: GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 2.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,

        children: [
          _BuildKeyButton(digit: '1', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '2', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '3', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '4', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '5', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '6', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '7', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '8', onNumberPressed: onNumberPressed),
          _BuildKeyButton(digit: '9', onNumberPressed: onNumberPressed),
          const SizedBox.shrink(),
          _BuildKeyButton(digit: '0', onNumberPressed: onNumberPressed),
          _BuildBackspaceButton(onBackspacePressed: onBackspacePressed),
        ],
      ),
    );
  }
}

class _BuildKeyButton extends StatelessWidget {
  final String digit;
  final ValueChanged<String>? onNumberPressed;
  const _BuildKeyButton({required this.digit, this.onNumberPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onNumberPressed?.call(digit),
        splashColor: SoloChallengeTheme.primary.withValues(alpha: 0.25),
        highlightColor: SoloChallengeTheme.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),

        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: Text(
            digit,
            style: SoloChallengeTheme.displayStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: SoloChallengeTheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildBackspaceButton extends StatelessWidget {
  final VoidCallback? onBackspacePressed;
  const _BuildBackspaceButton({this.onBackspacePressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onBackspacePressed,
        splashColor: SoloChallengeTheme.error.withValues(alpha: 0.25),
        highlightColor: SoloChallengeTheme.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: const Icon(
            Icons.backspace_outlined,
            color: SoloChallengeTheme.onSurfaceVariant,
            size: 26,
          ),
        ),
      ),
    );
  }
}
