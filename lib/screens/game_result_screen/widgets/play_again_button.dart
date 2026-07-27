import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class PlayAgainButton extends StatelessWidget {
  final String roomID;

  const PlayAgainButton({super.key, required this.roomID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.back();
        HiveService.clearStorageAttempts(roomID);
        HiveService.clearStoragePlayers(roomID);
      },
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD674FF), Color(0xFF00EEFC)],
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Play Again',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0B0B0B),
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
