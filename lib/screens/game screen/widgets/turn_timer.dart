import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Functions/game_utils.dart';
import 'package:guess_duel/cubit/Player%20turn/player_turn_cubit.dart';

class TurnTimer extends StatefulWidget {
  final bool isYourTurn;
  final String roomID;
  const TurnTimer({super.key, required this.isYourTurn, required this.roomID});

  @override
  State<TurnTimer> createState() => _TurnTimerState();
}

class _TurnTimerState extends State<TurnTimer> {
  int remainingTime = 40;
  Timer? timer;

  @override
  void initState() {
    if (widget.isYourTurn) {
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
        remainingTime = 40;
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
    return Row(
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
    );
  }
}
