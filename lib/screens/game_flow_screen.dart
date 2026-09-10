import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:guess_duel/Widgets/exit_lobby_dialog.dart';
import 'package:guess_duel/Widgets/text.dart';
import 'package:guess_duel/cubit/Player%20turn/player_turn_cubit.dart';
import 'package:guess_duel/cubit/lobby/lobby_cubit.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_cubit.dart';

import 'package:guess_duel/cubit/start%20game/game_status_cubit.dart';
import 'package:guess_duel/cubit/start%20game/game_status_state.dart';
import 'package:guess_duel/pageview.dart';
import 'package:guess_duel/cubit/Attempts/attempts_cubit.dart';
import 'package:guess_duel/screens/game%20screen/game_screen.dart';
import 'package:guess_duel/screens/lobby%20Screen/lobby_screen.dart';
import 'package:guess_duel/screens/Secret%20Number%20Screen/secret_number_screen.dart';

class GameFlowScreen extends HookWidget {
  final String roomID;
  const GameFlowScreen({super.key, required this.roomID});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LobbyCubit()..getRoomData(roomID)),
        BlocProvider(create: (_) => AttemptsCubit()),
        BlocProvider(create: (_) => PlayerTurnCubit()),
        BlocProvider(create: (_) => NumpadCubit()),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final gameCubit = context.read<GameStatusCubit>();
          bool shouldPop = await showExitLobbyDialog(
            context,
            roomID,
            gameCubit,
          );

          if (shouldPop) {
            Get.offAll(() => const Pages());
          }
        },
        child: BlocConsumer<GameStatusCubit, GameStatusState>(
          listener: (context, state) {
            if (state is GameStartFailure) {
              Get.snackbar("Error", state.errorM);
            }
          },
          builder: (context, state) {
            switch (state) {
              case GameStateLoading():
                return const _LoadingScreen();
              case LobbyState():
                return LobbyScreen(roomId: roomID);
              case SecretNumberState():
                return SecretNumberScreen(roomID: roomID);
              case PlayingState():
                return GameScreen(roomID: roomID);
              case GameStateFailure():
                return FailureScreen(message: state.errorM);
              case GameStateDissmissed():
                return const FailureScreen(message: "Room is Dismissed");
              default:
                return LobbyScreen(roomId: roomID);
            }
          },
        ),
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 96,
              height: 96,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC3F5FF)),
                strokeWidth: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FailureScreen extends StatelessWidget {
  final String? message;
  const FailureScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CText(data: message ?? "SomeThing Wrong", size: 30)),
    );
  }
}
