import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class PlayersIndicator extends StatelessWidget {
  final List<String> players;
  const PlayersIndicator({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    final player1 = players.isNotEmpty ? players[0] : 'YOU';
    final player2 = players.length > 1 ? players[1] : 'OPPONENT';

    bool isSolo = player2.toUpperCase() == 'SOLO';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // Player 1
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF2A2A2A),
                  border: Border.all(
                    color: const Color(0xFFDAB9FF).withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDAB9FF).withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFFDAB9FF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                player1.toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE5E2E1),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Divider
          Container(
            height: 32,
            width: 1,
            color: const Color(0xFF4D4356).withValues(alpha: 0.2),
          ),

          const Spacer(),

          // Player 2 (mirrored)
          Row(
            children: [
              Text(
                isSolo ? 'SOLO GAME' : player2.toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE5E2E1),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF2A2A2A),
                  border: Border.all(
                    color: const Color(0xFFD3FBFF).withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD3FBFF).withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(
                  isSolo ? RemixIcons.computer_line : Icons.account_circle,
                  color: const Color(0xFFD3FBFF),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
