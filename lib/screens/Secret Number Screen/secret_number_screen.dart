import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Secret%20number/secret_number_cubit.dart';
import 'package:guess_duel/cubit/Secret%20number/secret_number_state.dart';
import 'package:guess_duel/screens/Secret%20Number%20Screen/widgets/confirm_number_button.dart';
import 'package:guess_duel/screens/Secret%20Number%20Screen/widgets/secret_number_boxes.dart';
import 'package:guess_duel/screens/Secret%20Number%20Screen/widgets/secret_number_keypad.dart';
import 'package:guess_duel/screens/Secret%20Number%20Screen/widgets/secret_number_title.dart';
import 'package:guess_duel/screens/Secret%20Number%20Screen/secret_number_waiting_screen.dart';

class SecretNumberScreen extends StatelessWidget {
  final String roomID;
  const SecretNumberScreen({super.key, required this.roomID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecretNumberCubit(),
      child: BlocBuilder<SecretNumberCubit, SecretNumberState>(
        builder: (context, state) {
          Widget buildWidget() {
            if (state.roomFlow == RoomFlow.waiting) {
              return const SecretNumberWaitingScreen();
            } else if (state.roomFlow == RoomFlow.filling) {
              return entryState(context, state);
            } else {
              return const Text("data");
            }
          }

          return Scaffold(
            backgroundColor: const Color(0xFF131313),
            body: buildWidget(),
          );
        },
      ),
    );
  }

  Widget entryState(BuildContext context, SecretNumberState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ListView(
        children: [
          const SizedBox(height: 40),

          const SecretNumberTitle(),

          const SizedBox(height: 48),

          SecretNumberBoxes(state: state),

          const SizedBox(height: 32),

          const SecretNumberKeypad(),

          const SizedBox(height: 32),

          ConfirmNumberButton(roomID: roomID),
        ],
      ),
    );
  }
}
