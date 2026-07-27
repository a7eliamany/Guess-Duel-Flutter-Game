import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Widgets/loading.dart';
import 'package:guess_duel/cubit/lobby/lobby_cubit.dart';
import 'package:guess_duel/cubit/lobby/lobby_state.dart';
import 'package:guess_duel/screens/lobby%20Screen/widgets/lobby_header.dart';
import 'package:guess_duel/screens/lobby%20Screen/widgets/lobby_loaded_view.dart';

class LobbyScreen extends StatelessWidget {
  final String roomId;
  const LobbyScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 36),

            LobbyHeader(roomId: roomId),

            const SizedBox(height: 64),

            BlocBuilder<LobbyCubit, LobbyDataState>(
              builder: (context, state) {
                if (state is LobbyLoading) {
                  return const LoadingWidget();
                }

                if (state is LobbyFailure) {
                  return Center(child: Text(state.errorM));
                }

                if (state is LobbyLoaded) {
                  return LobbyLoadedView(
                    roomID: roomId,
                    lobbyModel: state.lobbyModel,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
