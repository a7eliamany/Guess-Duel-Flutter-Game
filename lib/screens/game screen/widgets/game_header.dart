import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Player%20turn/player_turn_cubit.dart';
import 'package:guess_duel/screens/game%20screen/widgets/turn_timer.dart';

class GameHeader extends StatelessWidget {
  final String roomID;
  const GameHeader({super.key, required this.roomID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerTurnCubit, bool>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFa9ffac).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: (state) ? const Color(0xFFa9ffac) : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),

              (state)
                  ? const Text(
                      'Your Turn',
                      style: TextStyle(
                        color: Color(0xFFa9ffac),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    )
                  : const Text(
                      'Opponent Turn',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

              const SizedBox(width: 7),

              (state)
                  ? TurnTimer(isYourTurn: state, roomID: roomID)
                  : const Text(""),
            ],
          ),
        );
      },
    );
  }
}
