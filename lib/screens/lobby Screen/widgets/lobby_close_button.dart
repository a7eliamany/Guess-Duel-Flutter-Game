import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:guess_duel/cubit/navigation%20bottom%20bar/navigation_bottombar_cubit.dart';
import 'package:guess_duel/cubit/start%20game/game_status_cubit.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/lobby_model.dart';
import 'package:guess_duel/pageview.dart';

class LobbyCloseButton extends StatelessWidget {
  final LobbyModel lobbyModel;
  const LobbyCloseButton({super.key, required this.lobbyModel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: const Color(0xFF27272a).withValues(alpha: 0.3),
          ),
        ),
      ),
      onPressed: () {
        final PlayerRole playerRole = lobbyModel.currentPlayer.playerRole;
        Get.dialog(
          AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              playerRole == PlayerRole.host ? 'End Lobby?' : 'Leave Lobby?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              playerRole == PlayerRole.host
                  ? 'As the host, leaving will close the lobby and remove all players.'
                  : 'Are you sure you want to leave the lobby?',
              style: const TextStyle(color: Colors.white70, height: 1.4),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<GameStatusCubit>().closeLobby(
                    lobbyModel.roomModel.roomId,
                  );

                  Get.offAll(const Pages(index: 0));
                },
                child: Text(
                  playerRole == PlayerRole.host ? 'End' : 'Leave',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
      child: const Text(
        "Exit",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
