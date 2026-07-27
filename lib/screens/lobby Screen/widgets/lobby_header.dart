import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LobbyHeader extends StatelessWidget {
  final String roomId;
  const LobbyHeader({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'LOBBY ENTRANCE',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFa1a1aa),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.2,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              roomId,
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.w900,
                color: Color(0xFFffffff),
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.content_copy, color: Color(0xFFa1a1aa)),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: roomId));

                Get.snackbar(
                  duration: const Duration(seconds: 1),
                  "Copied!",
                  "Room ID Copied to clipboard!",
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
