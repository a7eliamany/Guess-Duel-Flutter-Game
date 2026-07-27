import 'package:flutter/material.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/lobby_model.dart';
import 'package:guess_duel/screens/lobby%20Screen/widgets/lobby_close_button.dart';
import 'package:guess_duel/screens/lobby%20Screen/widgets/lobby_start_button.dart';
import 'package:guess_duel/screens/lobby%20Screen/widgets/lobby_status_row.dart';
import 'package:guess_duel/screens/lobby%20Screen/widgets/players_card.dart';

class LobbyLoadedView extends StatelessWidget {
  final LobbyModel lobbyModel;
  final String roomID;
  const LobbyLoadedView({
    super.key,
    required this.lobbyModel,
    required this.roomID,
  });

  @override
  Widget build(BuildContext context) {
    final players = lobbyModel.roomPlayers;
    final host = players.firstWhere(
      (p) => p.playerRole == PlayerRole.host,
      orElse: () => players.first,
    );
    final String statusText = players.length > 1
        ? 'READY TO START'
        : 'Waiting for opponent...';
    final bool showRequiredText = players.length < 2;

    Widget playersWidget = Column(
      children: [
        PlayerOneHost(roomPlayer: host),
        const PlayerPassive(number: 2),
      ],
    );

    if (players.length > 1) {
      final playerTwo = players.firstWhere(
        (p) => p.playerRole == PlayerRole.player,
      );

      playersWidget = Column(
        children: [
          PlayerOneHost(roomPlayer: host),
          PlayerTwoActive(roomPlayer: playerTwo),
        ],
      );
    }

    return Column(
      children: [
        LobbyStatusRow(text: statusText),

        const SizedBox(height: 30),

        playersWidget,

        const SizedBox(height: 64),

        if (showRequiredText)
          const Text(
            'REQUIRED: 2 PLAYERS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.6,
            ),
          ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: LobbyStartButton(
            lobbyModel: lobbyModel,
            playersCount: players.length,
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: LobbyCloseButton(lobbyModel: lobbyModel),
        ),
      ],
    );
  }
}
