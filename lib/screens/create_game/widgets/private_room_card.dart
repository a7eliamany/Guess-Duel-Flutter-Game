import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_toggle_switch.dart';

class PrivateRoomCard extends StatelessWidget {
  final bool isPrivate;
  final ValueChanged<bool> onChanged;

  const PrivateRoomCard({
    super.key,
    required this.isPrivate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF3B494C).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF582A9F).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lock,
              color: Color(0xFFD4BBFF),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Private Room",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFE5E2E1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Require a password to join",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFBAC9CC),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          CustomToggleSwitch(
            value: isPrivate,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
