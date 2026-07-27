import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:guess_duel/cubit/start%20game/game_status_cubit.dart';
import 'package:guess_duel/cubit/start%20game/game_status_state.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/lobby_model.dart';

class LobbyStartButton extends StatelessWidget {
  final LobbyModel lobbyModel;
  final int playersCount;

  const LobbyStartButton({
    super.key,
    required this.lobbyModel,
    required this.playersCount,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (lobbyModel.roomPlayers.length > 1)
          ? () async {
              final cubit = context.read<GameStatusCubit>();
              final currentPlayer = lobbyModel.currentPlayer;
              final RoomPlayer pLayer = lobbyModel.roomPlayers.firstWhere(
                (player) => player.playerRole == PlayerRole.player,
              );

              final bool isPlayerReady =
                  pLayer.roomPlayerStatus == RoomPlayerStatus.ready;

              if (currentPlayer.playerRole == PlayerRole.host) {
                cubit.startGame(
                  lobbyModel.roomModel.roomId,
                  isPlayerReady,
                  pLayer,
                );
              } else if (currentPlayer.playerRole == PlayerRole.player) {
                cubit.toggleReady(lobbyModel.roomModel.roomId, currentPlayer);
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,

        disabledBackgroundColor: const Color(
          0xFFffffff,
        ).withValues(alpha: 0.05),
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: const Color(0xFF27272a).withValues(alpha: 0.3),
          ),
        ),
      ),
      child: BlocConsumer<GameStatusCubit, GameStatusState>(
        listener: (context, state) {
          if (state is GameStateFailure) {
            Get.snackbar("Error", state.errorM);
          }
        },
        builder: (context, state) {
          return LobbyStartTextButton(
            playerRole: lobbyModel.currentPlayer.playerRole,
            roomPlayerLength: playersCount,
          );
        },
      ),
    );
  }
}

class LobbyStartTextButton extends StatelessWidget {
  final int roomPlayerLength;
  final PlayerRole playerRole;
  const LobbyStartTextButton({
    super.key,
    required this.roomPlayerLength,
    required this.playerRole,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (playerRole == PlayerRole.host) ? 'START GAME' : "Ready",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: (roomPlayerLength > 1) ? Colors.black : const Color(0xFFa1a1aa),
        letterSpacing: 2,
      ),
    );
  }
}
