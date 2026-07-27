import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';

class RoomCard extends StatelessWidget {
  final RoomModel roomModel;
  final VoidCallback onJoin;
  const RoomCard({super.key, required this.roomModel, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1c1b1b),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${roomModel.roomName} Room",
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFe5e2e1),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.group, size: 16, color: Color(0xFFc3f5ff)),
                  const SizedBox(width: 8),
                  Text(
                    '${roomModel.playersCount}/2 players',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF849396),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onJoin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFc3f5ff),
              foregroundColor: const Color(0xFF00363d),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Join',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
