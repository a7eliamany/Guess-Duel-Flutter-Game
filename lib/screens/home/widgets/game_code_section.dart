import 'package:flutter/material.dart';
import 'package:guess_duel/screens/home/widgets/room_code_field.dart';

class GameCodeSection extends StatelessWidget {
  final TextEditingController codeController;
  final GlobalKey<FormState> gameCodeKey;
  const GameCodeSection({
    super.key,
    required this.codeController,
    required this.gameCodeKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "GAME ACCESS CODE",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        RoomCodeField(codeController: codeController, gameCodeKey: gameCodeKey),
      ],
    );
  }
}
