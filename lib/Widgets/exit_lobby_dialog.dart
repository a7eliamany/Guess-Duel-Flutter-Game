import 'package:flutter/material.dart';
import 'package:guess_duel/Widgets/app_dialog.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';

import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/cubit/start game/game_status_cubit.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

Future<bool> showExitLobbyDialog(
  BuildContext context,
  String roomID,
  GameStatusCubit gameCubit,
) async {
  // 1. Get host status synchronously from local Hive cache to prevent UI lag
  final RoomModel room = HiveService.roomsBox.get(roomID);
  final currentUserId = SharedPrefService.getId();
  final bool isHost = room.hostId == currentUserId;

  // 2. Show the stylized premium AppDialog
  bool didConfirm = false;
  await AppDialog.show(
    context: context,
    title: isHost ? 'End Lobby?' : 'Leave Lobby?',
    message: isHost
        ? 'As the host, leaving will close the lobby and remove all players.'
        : 'Are you sure you want to leave the lobby?',
    icon: Icons.exit_to_app,
    accentColor: Colors.redAccent,
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          gameCubit.closeLobby(roomID);
          didConfirm = true;
          Navigator.pop(context);
        },
        child: Text(
          isHost ? 'End' : 'Leave',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ],
  );

  return didConfirm;
}
