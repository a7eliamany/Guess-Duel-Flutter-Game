import 'package:flutter/material.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:remixicon/remixicon.dart';

class PlayerOneHost extends StatelessWidget {
  final RoomPlayer roomPlayer;
  const PlayerOneHost({super.key, required this.roomPlayer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 82,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: ListTile(
          trailing: Icon(RemixIcons.check_double_fill, color: Colors.blue),
          title: Text(
            "${roomPlayer.playerModel.username}(host)",

            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
            radius: 30,
            child: Icon(RemixIcons.user_5_fill),
          ),
        ),
      ),
    );
  }
}

class PlayerPassive extends StatelessWidget {
  final int number;
  const PlayerPassive({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0a0a0a).withValues(alpha: .5),
        border: Border.all(
          color: const Color(0xFF27272a).withValues(alpha: 0.3),
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Opacity(
        opacity: 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF141414),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person, color: Color(0xFFa1a1aa)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Player $number',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'SEARCHING...',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFa1a1aa),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  const Color(0xFF8ff5ff).withValues(alpha: 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerTwoActive extends StatelessWidget {
  final RoomPlayer roomPlayer;
  const PlayerTwoActive({super.key, required this.roomPlayer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 82,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: ListTile(
          title: Text(
            roomPlayer.playerModel.username,

            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(RemixIcons.user_2_fill),
          ),
          trailing: (roomPlayer.roomPlayerStatus == RoomPlayerStatus.ready)
              ? Icon(RemixIcons.check_double_line, color: Colors.blue)
              : null,
        ),
      ),
    );
  }
}
