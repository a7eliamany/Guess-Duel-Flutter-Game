import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guess_duel/cubit/Player%20turn/player_turn_cubit.dart';
import 'package:guess_duel/cubit/Attempts/attempts_cubit.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_cubit.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_state.dart';
import 'package:guess_duel/screens/game%20screen/numpad.dart';
import 'package:guess_duel/screens/game%20screen/widgets/attempts_history.dart';
import 'package:guess_duel/screens/game%20screen/widgets/code_input.dart';
import 'package:guess_duel/screens/game%20screen/widgets/game_header.dart';
import 'package:guess_duel/screens/game%20screen/widgets/history_title.dart';
import 'package:guess_duel/screens/game%20screen/widgets/submit_button.dart';

class GameScreen extends HookWidget {
  final String roomID;
  const GameScreen({super.key, required this.roomID});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<AttemptsCubit>().getAttempts(roomID);
      context.read<PlayerTurnCubit>().checkPlayerTurn(roomID);

      return null;
    }, [roomID]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Status Indicator
            GameHeader(roomID: roomID),

            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your 4-digit code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFadaaaa),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Input Section
                  const CodeInput(),

                  const SizedBox(height: 32),
                  // Keypad
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Numpad(),
                  ),
                  const SizedBox(height: 16),

                  BlocBuilder<NumpadCubit, NumpadState>(
                    builder: (context, state) {
                      return SubmitButton(code: state.code, roomID: roomID);
                    },
                  ),

                  const SizedBox(height: 32),

                  // History Section
                  const HistoryTitle(),
                  Divider(
                    color: const Color(0xFF767575).withValues(alpha: 0.1),
                  ),
                  const AttemptsHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
