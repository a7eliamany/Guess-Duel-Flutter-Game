import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Widgets/gradient_button.dart';
import 'package:guess_duel/Widgets/keypad.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_cubit.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_state.dart';
import 'package:guess_duel/cubit/keypad/keypad_cubit.dart';
import 'package:guess_duel/cubit/keypad/keypad_state.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/submit_button.dart';
import 'package:guess_duel/theme/solo_challenge_theme.dart';

class SoloBottomInput extends StatelessWidget {
  final VoidCallback resultsButtonCallback;
  final VoidCallback submitButtonCallback;
  final VoidCallback backspaceButtonCallback;
  final void Function(String)? onNumberPressed;

  const SoloBottomInput({
    super.key,
    required this.resultsButtonCallback,
    required this.submitButtonCallback,
    required this.backspaceButtonCallback,
    required this.onNumberPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRect(
          child: Container(
            decoration: BoxDecoration(
              color: SoloChallengeTheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              border: const Border(
                top: BorderSide(
                  color: SoloChallengeTheme.glassHeaderBorder,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
            ),
            child: BlocBuilder<SoloGameCubit, SoloGameState>(
              buildWhen: (previous, current) =>
                  current.gameState != previous.gameState,
              builder: (context, state) {
                if (state.gameState == GameState.playing) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Keypad(
                        onNumberPressed: onNumberPressed,
                        onBackspacePressed: backspaceButtonCallback,
                      ),
                      const SizedBox(height: 16),

                      BlocBuilder<KeypadCubit, KeypadState>(
                        builder: (context, state) {
                          return SubmitButton(
                            onSubmitPressed: submitButtonCallback,
                            isComplete: state.isReadyToSubmit,
                          );
                        },
                      ),
                    ],
                  );
                } else if (state.gameState == GameState.gameover) {
                  return GradientButton(
                    text: "Result",
                    gradientColors: const [
                      Colors.white70,
                      Colors.teal,
                      Colors.teal,
                    ],
                    icon: Icons.forward,
                    onPressed: resultsButtonCallback,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
