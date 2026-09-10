import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/screens/offline%20game%20screens/create_offline_game/widgets/attempts_slider.dart';
import 'package:guess_duel/Widgets/segmented_selector.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';

class CustomSetupPanel extends StatelessWidget {
  final int selectedDigits;
  final ValueChanged<int> onDigitsChanged;

  final int maxAttempts;
  final ValueChanged<int> onAttemptsChanged;

  final String selectedTimer;
  final ValueChanged<String> onTimerChanged;

  final bool allowRepeatedDigits;
  final ValueChanged<bool> onAllowRepeatedChanged;

  const CustomSetupPanel({
    super.key,
    required this.selectedDigits,
    required this.onDigitsChanged,
    required this.maxAttempts,
    required this.onAttemptsChanged,
    required this.selectedTimer,
    required this.onTimerChanged,
    required this.allowRepeatedDigits,
    required this.onAllowRepeatedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Digits Control
        Text(
          'Number Length',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFCFC2D9),
          ),
        ),
        const SizedBox(height: 8),
        SegmentedSelector<int>(
          items: const [3, 4, 5, 6],
          selectedItem: selectedDigits,
          onSelected: onDigitsChanged,
        ),

        const SizedBox(height: 20),

        // Max Attempts Control
        AttemptsSlider(
          value: maxAttempts.toDouble(),
          min: 5,
          max: 30,
          onChanged: (val) => onAttemptsChanged(val.round()),
        ),

        const SizedBox(height: 20),

        // Timer Control
        Text(
          'Timer Duration',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFCFC2D9),
          ),
        ),
        const SizedBox(height: 8),
        SegmentedSelector<String>(
          items: [
            TimerType.unlimited.label,
            TimerType.twoMinutes.label,
            TimerType.threeMinutes.label,
            TimerType.fiveMinutes.label,
            TimerType.tenMinutes.label,
          ],
          selectedItem: selectedTimer,
          onSelected: onTimerChanged,
        ),

        const SizedBox(height: 20),

        // Repeated Digits Toggle
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0x334D4356), width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.repeat_rounded,
                    color: Color(0xFFDAB9FF),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Allow Repeated Digits',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: const Color(0xFFE5E2E1),
                    ),
                  ),
                ],
              ),
              Switch(
                value: allowRepeatedDigits,
                activeThumbColor: const Color(0xFF8F00FF),
                activeTrackColor: const Color(
                  0xFF8F00FF,
                ).withValues(alpha: 0.5),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFF353534),
                onChanged: onAllowRepeatedChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
