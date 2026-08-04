import 'package:flutter/material.dart';
import '../../../../theme/solo_challenge_theme.dart';

class NumberDisplay extends StatefulWidget {
  final int digits;
  final String value;
  final int? selectedIndex;
  final ValueChanged<int>? onDigitTap;

  const NumberDisplay({
    super.key,
    required this.digits,
    required this.value,
    this.selectedIndex,
    this.onDigitTap,
  });

  @override
  State<NumberDisplay> createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.2, end: 0.9).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cleanValue = widget.value.replaceAll('_', '');

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dynamic dimensions based on available width and digit count
        final double totalPadding = (widget.digits - 1) * 10.0;
        final double availableWidth = constraints.maxWidth - 32;
        final double maxBoxWidth = widget.digits <= 4
            ? 64.0
            : widget.digits == 5
            ? 56.0
            : 48.0;
        final double calculatedWidth =
            ((availableWidth - totalPadding) / widget.digits).clamp(
              36.0,
              maxBoxWidth,
            );
        final double boxHeight = (calculatedWidth * 1.3).clamp(52.0, 80.0);
        final double fontSize = (calculatedWidth * 0.6).clamp(22.0, 36.0);

        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.digits, (index) {
              final char =
                  (index < widget.value.length && widget.value[index] != '_')
                  ? widget.value[index]
                  : '';
              final isFilled = char.isNotEmpty;
              final isCurrentFocus = widget.selectedIndex != null
                  ? index == widget.selectedIndex
                  : (index == cleanValue.length ||
                        (cleanValue.length == widget.digits &&
                            index == widget.digits - 1));

              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.digits - 1 ? 0 : 10.0,
                ),
                child: GestureDetector(
                  onTap: () => widget.onDigitTap?.call(index),
                  child: Container(
                    width: calculatedWidth,
                    height: boxHeight,
                    decoration: BoxDecoration(
                      color: isFilled
                          ? SoloChallengeTheme.surfaceContainerHigh
                          : SoloChallengeTheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: isFilled
                          ? [
                              BoxShadow(
                                color: SoloChallengeTheme.primaryContainer
                                    .withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                      border: Border(
                        bottom: BorderSide(
                          color: isCurrentFocus
                              ? SoloChallengeTheme.primary
                              : (isFilled
                                    ? SoloChallengeTheme.primary.withOpacity(
                                        0.5,
                                      )
                                    : SoloChallengeTheme.outlineVariant),
                          width: isCurrentFocus ? 3 : 2,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isFilled
                        ? Text(
                            char,
                            style: SoloChallengeTheme.displayStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: SoloChallengeTheme.primary,
                            ),
                          )
                        : (isCurrentFocus
                              ? FadeTransition(
                                  opacity: _pulseAnimation,
                                  child: Text(
                                    '_',
                                    style: SoloChallengeTheme.displayStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                      color: SoloChallengeTheme.onSurfaceVariant
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                )
                              : Text(
                                  '_',
                                  style: SoloChallengeTheme.displayStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: SoloChallengeTheme.onSurfaceVariant
                                        .withOpacity(0.3),
                                  ),
                                )),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
