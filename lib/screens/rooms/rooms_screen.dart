import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/loading.dart';
import 'package:guess_duel/Widgets/text.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_cubit.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_state.dart';
import 'package:guess_duel/cubit/Rooms/rooms_cubit.dart';
import 'package:guess_duel/cubit/Rooms/rooms_state.dart';
import 'package:guess_duel/cubit/start%20game/game_status_cubit.dart';
import 'package:guess_duel/screens/game_flow_screen.dart';
import 'package:guess_duel/screens/rooms/widgets/rooms_header.dart';
import 'package:guess_duel/screens/rooms/widgets/rooms_list.dart';

class RoomsScreen extends HookWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //initState

    useEffect(() {
      context.read<RoomsCubit>().listenToRooms();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Game Rooms',
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFc3f5ff),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RoomsHeader(),
            const SizedBox(height: 48),
            BlocListener<JoinRoomCubit, JoinRoomState>(
              listener: (context, state) {
                if (state is JoinRoomLoading) {
                  Get.snackbar(
                    "Joining...",
                    "Please wait",
                    duration: const Duration(seconds: 1),
                  );
                }

                if (state is JoinRoomLoaded) {
                  Get.snackbar(
                    "Joined",
                    "You have joined the room",
                    duration: const Duration(seconds: 1),
                  );
                  Get.to(
                    BlocProvider(
                      create: (_) =>
                          GameStatusCubit()..gameStatusListen(state.roomId),
                      child: GameFlowScreen(roomID: state.roomId),
                    ),
                  );
                }

                if (state is JoinRoomFailure) {
                  Get.snackbar("Error", state.errorM);
                }
              },
              child: BlocBuilder<RoomsCubit, RoomsState>(
                builder: (context, state) {
                  if (state is RoomsLoading) {
                    return const Expanded(child: LoadingWidget());
                  }

                  if (state is RoomsError) {
                    return Text("Error: ${state.error}");
                  }
                  if (state is RoomsLoaded) {
                    final rooms = state.rooms;

                    if (rooms.isEmpty) {
                      return const Expanded(
                        child: Center(child: CText(data: "No Rooms", size: 30)),
                      );
                    } else {
                      return Expanded(child: RoomsList(rooms: rooms));
                    }
                  } else {
                    return const Text("");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
