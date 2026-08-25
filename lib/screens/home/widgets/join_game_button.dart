import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:guess_duel/Widgets/glow_button.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_cubit.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_state.dart';
import 'package:guess_duel/cubit/start%20game/game_status_cubit.dart';
import 'package:guess_duel/screens/game_flow_screen.dart';
import 'package:remixicon/remixicon.dart';

import 'package:guess_duel/screens/home/widgets/room_password_dialog.dart';

class JoinGameButton extends StatelessWidget {
  final TextEditingController codeController;
  final GlobalKey<FormState> gameCodeKey;
  const JoinGameButton({
    super.key,
    required this.codeController,
    required this.gameCodeKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinRoomCubit, JoinRoomState>(
      listener: (context, state) {
        if (state is CheckingRoomPassword) {
          RoomPasswordDialog.showBottomSheet(
            context,
            expectedPassword: state.password,
            roomCode: codeController.text.toUpperCase(),
            onSuccess: (value) {
              context.read<JoinRoomCubit>().joinRoom(
                codeController.text.toUpperCase(),
              );
            },
          );
        }
        if (state is JoinRoomLoaded) {
          Get.to(
            BlocProvider(
              create: (_) =>
                  GameStatusCubit()
                    ..gameStatusListen(codeController.text.toUpperCase()),
              child: GameFlowScreen(roomID: codeController.text.toUpperCase()),
            ),
          );
        }
        if (state is JoinRoomFailure) {
          Get.snackbar("Error", state.errorM);
        }
      },
      builder: (context, state) {
        final isNotEnabled = (state is JoinRoomLoading);
        return GlowButton(
          text: "JOIN GAME",
          icon: RemixIcons.login_box_line,
          isEnabled: !isNotEnabled,
          loadingText: "Loading",

          onPressed: () async {
            if (gameCodeKey.currentState!.validate()) {
              await context.read<JoinRoomCubit>().checkRoomStatus(
                codeController.text.toUpperCase(),
              );
            }
          },
        );
      },
    );
  }
}
