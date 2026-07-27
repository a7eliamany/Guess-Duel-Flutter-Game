import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:guess_duel/cubit/Attempts/attempts_cubit.dart';
import 'package:guess_duel/cubit/Player%20turn/player_turn_cubit.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_cubit.dart';

class SubmitButton extends StatelessWidget {
  final String code;
  final String roomID;
  const SubmitButton({super.key, required this.code, required this.roomID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerTurnCubit, bool>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: (state)
              ? () async {
                  int index = code.indexOf('_');
                  if (index != -1 && code[index] == '_') {
                    Get.snackbar("Error", "Code must be 4-digit");
                  } else {
                    context.read<PlayerTurnCubit>().changeTurn(roomID);

                    context.read<AttemptsCubit>().addAttempts(roomID, code);
                    context.read<NumpadCubit>().clearCode();
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8ff5ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 0),
          ),
          child: const Text(
            'Submit Guess',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        );
      },
    );
  }
}
