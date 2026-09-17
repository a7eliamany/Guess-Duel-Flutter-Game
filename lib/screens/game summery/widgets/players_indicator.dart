import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:remixicon/remixicon.dart';

class PlayersIndicator extends StatelessWidget {
  final List<PlayerModel> players;
  const PlayersIndicator({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    final PlayerModel player1 = players[0];
    final PlayerModel? player2 = players.length > 1 ? players[1] : null;

    bool isSolo = player2 == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // Player 1
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: SvgPicture.asset(
                    AppAvatars.getAvatarById(player1.avatarID).assetPath,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    player1.username.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE5E2E1),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Divider
          Container(
            height: 32,
            width: 1,
            color: const Color(0xFF4D4356).withValues(alpha: 0.2),
          ),

          const SizedBox(width: 12),

          // Player 2 (mirrored)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    isSolo ? 'SOLO GAME' : player2.username.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE5E2E1),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                !isSolo
                    ? CircleAvatar(
                        radius: 25,
                        child: SvgPicture.asset(
                          AppAvatars.getAvatarById(player2.avatarID).assetPath,
                        ),
                      )
                    : const Icon(
                        RemixIcons.computer_line,
                        size: 30,
                        color: Color(0xFFE5E2E1),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
