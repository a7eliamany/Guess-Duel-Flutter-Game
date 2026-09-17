import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/segmented_selector.dart';
import 'package:guess_duel/models/Room%20Settings/room_settings_model.dart';
import 'package:guess_duel/screens/create_game/widgets/private_room_card.dart';

class RoundTimeSelector extends StatelessWidget {
  final int selectedItem;
  final void Function(int) onSelected;
  final void Function(bool) onChanged;

  final bool isEnabled;
  const RoundTimeSelector({
    super.key,
    required this.selectedItem,
    required this.onSelected,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrivateRoomCard(
          isPrivate: isEnabled,
          onChanged: onChanged,
          icon: Icons.timer,
          title: "Round Time",
          subtitle: "Every Player turn have time",
        ),
        const SizedBox(height: 20),

        AnimatedSize(
          duration: 200.milliseconds,
          child: isEnabled
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Time (Seconds)",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF849396),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SegmentedSelector<int>(
                      items: [
                        RoundTime.s30.toInt()!,
                        RoundTime.s45.toInt()!,
                        RoundTime.s60.toInt()!,
                        RoundTime.s75.toInt()!,
                        RoundTime.s90.toInt()!,
                      ],
                      selectedItem: selectedItem,
                      onSelected: onSelected,
                    ),
                    const SizedBox(height: 15),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
