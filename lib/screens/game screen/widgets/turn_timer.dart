import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Functions/game_utils.dart';
import 'package:guess_duel/cubit/Player%20turn/player_turn_cubit.dart';
import 'package:guess_duel/models/Room%20Settings/room_settings_model.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class TurnTimer extends StatefulWidget {
  final bool isYourTurn;
  final String roomID;
  const TurnTimer({super.key, required this.isYourTurn, required this.roomID});

  @override
  State<TurnTimer> createState() => _TurnTimerState();
}

class _TurnTimerState extends State<TurnTimer> {
  late int remainingTime;
  Timer? timer;
  late RoomSettingsModel roomSettingsModel;

  @override
  void initState() {
    roomSettingsModel = HiveService.roomSettings.get(widget.roomID);
    if (widget.isYourTurn && roomSettingsModel.isTimeEnabled == true) {
      remainingTime = roomSettingsModel.roundTime?.toInt() ?? 30;
      updateTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime == 0) {
        context.read<PlayerTurnCubit>().changeTurn(widget.roomID);
        remainingTime = roomSettingsModel.roundTime?.toInt() ?? 30;
        timer?.cancel();
        return;
      } else {
        if (mounted) {
          setState(() {
            remainingTime--;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (roomSettingsModel.isTimeEnabled ?? false)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer, size: 20),
              const SizedBox(width: 4),
              Text(
                GameUtils.getTime(remainingTime),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
