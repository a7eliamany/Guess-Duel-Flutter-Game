import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/cubit/Create%20game/create_game_cubit.dart';
import 'package:guess_duel/cubit/Create%20game/create_game_state.dart';
import 'package:guess_duel/cubit/start%20game/game_status_cubit.dart';
import 'package:guess_duel/models/Room%20Settings/room_settings_model.dart';
import 'package:guess_duel/screens/create_game/widgets/create_game_bottomsheet_cancel_button.dart';
import 'package:guess_duel/screens/create_game/widgets/create_game_bottomsheet_create_button.dart';
import 'package:guess_duel/screens/create_game/widgets/round_time_selector.dart';
import 'package:guess_duel/screens/game_flow_screen.dart';
import 'package:guess_duel/Widgets/segmented_selector.dart';
import 'widgets/room_name_input.dart';
import 'widgets/private_room_card.dart';
import 'widgets/password_input_card.dart';

class CreateGameBottomsheet extends StatefulWidget {
  const CreateGameBottomsheet({super.key});

  @override
  State<CreateGameBottomsheet> createState() => _CreateGameBottomsheetState();
}

class _CreateGameBottomsheetState extends State<CreateGameBottomsheet> {
  late final TextEditingController roomNameController;
  late final TextEditingController passwordController;
  RoomSettingsModel roomSettingsModel = RoomSettingsModel();

  @override
  void initState() {
    roomNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    roomNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFBAC9CC).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF131313),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border.all(
                  color: const Color(0xFF3B494C).withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Create Room",
                    style: GoogleFonts.manrope(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE5E2E1),
                      height: 1.1,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Create a room and invite your friends to play.",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFFBAC9CC),
                    ),
                  ),
                  const SizedBox(height: 40),
                  RoomNameInput(controller: roomNameController),
                  const SizedBox(height: 24),
                  PrivateRoomCard(
                    icon: Icons.lock,
                    title: "Private Room",
                    subtitle: "Require a password to join",
                    isPrivate: roomSettingsModel.isPrivate ?? false,
                    onChanged: (val) {
                      setState(() {
                        roomSettingsModel = roomSettingsModel.copyWith(
                          isPrivate: val,
                        );
                      });
                    },
                  ),

                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: (roomSettingsModel.isPrivate ?? false)
                          ? 1.0
                          : 0.0,
                      child: (roomSettingsModel.isPrivate ?? false)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: PasswordInputCard(
                                controller: passwordController,
                                onChanged: (val) {
                                  setState(() {
                                    roomSettingsModel = roomSettingsModel
                                        .copyWith(roomPassword: val);
                                  });
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RoundTimeSelector(
                    selectedItem: roomSettingsModel.roundTime?.toInt() ?? 30,
                    onSelected: (value) {
                      setState(() {
                        roomSettingsModel = roomSettingsModel.copyWith(
                          roundTime: RoundTimeToInt.fromInt(value),
                        );
                      });
                    },
                    isEnabled: roomSettingsModel.isTimeEnabled ?? false,
                    onChanged: (value) {
                      roomSettingsModel = roomSettingsModel.copyWith(
                        isTimeEnabled: value,
                      );
                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 48),
                  BlocConsumer<CreateRoomCubit, CreateRoomState>(
                    listener: (context, state) {
                      if (state is CreateRoomSuccess) {
                        Get.snackbar("Success", "Room Created Succsfully");
                        Navigator.of(context).pop();
                        Get.to(
                          BlocProvider(
                            create: (_) =>
                                GameStatusCubit()
                                  ..gameStatusListen(state.roomId),
                            child: GameFlowScreen(roomID: state.roomId),
                          ),
                        );
                        roomNameController.clear();
                      } else if (state is CreateRoomError) {
                        Get.snackbar("Error", state.error);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is CreateRoomLoading;
                      return CreateGameBottomsheetCreateButton(
                        isLoading: isLoading,
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (roomNameController.text.trim().isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Room name cannot be empty",
                                  );
                                  return;
                                }
                                await context
                                    .read<CreateRoomCubit>()
                                    .createRoom(
                                      roomNameController.text.trim(),
                                      roomSettingsModel,
                                    );
                              },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const CreateGameBottomsheetCancelButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
