import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guess_duel/Widgets/gradient_button.dart';
import 'package:guess_duel/Widgets/keypad.dart';
import 'package:guess_duel/cubit/History/history_cubit.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_cubit.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_state.dart';
import 'package:guess_duel/cubit/keypad/keypad_cubit.dart';
import 'package:guess_duel/cubit/keypad/keypad_state.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/solo_result_screen.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/attempt_history_item.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/challenge_stats_card.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/exit_dialog_solo.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/number_display.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/solo_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/submit_button.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/theme/solo_challenge_theme.dart';

class SoloChallengeScreen extends StatefulWidget {
  final OfflineGameModel oldOfflineGameModel;

  const SoloChallengeScreen({super.key, required this.oldOfflineGameModel});

  @override
  State<SoloChallengeScreen> createState() => _SoloChallengeScreenState();
}

class _SoloChallengeScreenState extends State<SoloChallengeScreen> {
  late KeypadCubit _keypadCubit;
  late SoloGameCubit _soloGameCubit;
  late OfflineGameModel updatedData;

  @override
  void initState() {
    super.initState();
    _keypadCubit = KeypadCubit(
      maxDigits: widget.oldOfflineGameModel.digits,
      allowDuplicates: widget.oldOfflineGameModel.allowRepeatedDigits,
    );
    _soloGameCubit = SoloGameCubit(
      offlineGameModel: widget.oldOfflineGameModel,
    );
    updatedData = widget.oldOfflineGameModel;
    _soloGameCubit.startTimer();
  }

  @override
  void dispose() {
    _keypadCubit.close();
    _soloGameCubit.close();
    super.dispose();
  }

  void _handleNumberPress(String digit) {
    _keypadCubit.onNumberPressed(
      digit: digit,

      targetIndex: _keypadCubit.state.index,
    );
  }

  void _handleBackspace() {
    _keypadCubit.onBackspacePressed();
  }

  void _handleSubmit() async {
    final currentInput = _keypadCubit.state.cleanInput;
    if (_keypadCubit.state.isComplete) {
      updatedData = await _soloGameCubit.addAttempt(currentInput, updatedData);
      _keypadCubit.clearInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _keypadCubit),
        BlocProvider.value(value: _soloGameCubit),
      ],

      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          bool shouldPop = await soloExitDialog(context: context);

          if (shouldPop) {
            Get.back();
          }
        },
        child: Scaffold(
          backgroundColor: SoloChallengeTheme.surface,
          extendBodyBehindAppBar: true,

          appBar: SoloHeader(
            onBackPressed: () async {
              bool shouldPop = await soloExitDialog(context: context);
              if (shouldPop) {
                Get.back();
              }
            },
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                // Scrollable top content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 64,
                    ),
                    child: Column(
                      children: [
                        // Header Stats Rail & Status Bento
                        ChallengeStatsCard(
                          modeName: updatedData.difficultyLevel.name,
                          digitCount: updatedData.digits,
                          totalTime: updatedData.duration.timeInSecs,
                          maxAttempts: updatedData.maxAttempts,
                        ),

                        // Active Input Field & Legend Chips
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              BlocBuilder<KeypadCubit, KeypadState>(
                                builder: (context, state) {
                                  return NumberDisplay(
                                    digits: widget.oldOfflineGameModel.digits,
                                    value: state.input,
                                    selectedIndex: state.index,
                                    onDigitTap: (index) {
                                      _keypadCubit.changeIndex(index);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // History Log
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 23,
                          ),
                          child: BlocListener<SoloGameCubit, SoloGameState>(
                            listener: (context, state) {
                              updatedData = state.offlineGameModel;
                              if (state.gameState == GameState.gameover) {
                                context.read<HistoryCubit>().addToHistory(
                                  roomID: updatedData.id,
                                  attempts: updatedData.history ?? [],
                                  isWin: state.isWin,
                                  players: ["me", "Solo"],
                                  secretCode: updatedData.secretCode,
                                  offlineGameModel: updatedData,
                                  isOffline: true,
                                );
                                HiveService.offlineGameBox.put(
                                  updatedData.id,
                                  updatedData,
                                );

                                if (state.isWin) {
                                  Get.to(
                                    () => SoloResultScreen(
                                      isWin: true,

                                      resultData: state.offlineGameModel,

                                      onRetryPressed: () {
                                        _soloGameCubit.soloRestartAction();
                                        Get.back();
                                      },
                                    ),
                                  );
                                } else if (!state.isWin) {
                                  Get.to(
                                    () => SoloResultScreen(
                                      isWin: state.isWin,
                                      resultData: state.offlineGameModel,

                                      onRetryPressed: () {
                                        _soloGameCubit.soloRestartAction();
                                        Get.back();
                                      },
                                    ),
                                  );
                                }
                              }
                            },
                            child:
                                BlocSelector<
                                  SoloGameCubit,
                                  SoloGameState,
                                  List<AttemptModel>
                                >(
                                  selector: (state) =>
                                      state.offlineGameModel.history ??
                                      updatedData.history!,
                                  builder: (context, history) {
                                    return AttemptHistoryList(
                                      history: history.reversed.toList(),
                                      onTap: (val) {
                                        _keypadCubit.loadAttempt(
                                          history.reversed
                                              .toList()[val]
                                              .attempt,
                                          updatedData.digits,
                                          updatedData.maxAttempts,
                                        );
                                      },
                                    );
                                  },
                                ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Bottom Input Surface (Keypad & Submit CTA)
                ClipRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: SoloChallengeTheme.surfaceContainerHighest
                          .withValues(alpha: 0.3),
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
                                onNumberPressed: _handleNumberPress,
                                onBackspacePressed: _handleBackspace,
                              ),
                              const SizedBox(height: 16),

                              BlocBuilder<KeypadCubit, KeypadState>(
                                builder: (context, state) {
                                  return SubmitButton(
                                    onSubmitPressed: _handleSubmit,
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
                            onPressed: () {
                              Get.to(
                                () => SoloResultScreen(
                                  isWin: state.isWin,
                                  resultData: updatedData,
                                  onRetryPressed: () {
                                    _soloGameCubit.soloRestartAction();
                                    Get.back();
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
