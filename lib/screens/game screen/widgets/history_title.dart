import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HistoryTitle extends HookWidget {
  final String roomID;
  final void Function(bool val) update;
  const HistoryTitle({super.key, required this.roomID, required this.update});

  @override
  Widget build(BuildContext context) {
    final isOnlyYourAttempts = useState(false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Attempt History',
          style: TextStyle(
            color: Color(0xFF767575),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        Row(
          children: [
            const Text(
              "You",
              style: TextStyle(
                color: Color(0xFF767575),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            Transform.scale(
              scale: 0.75,
              child: Switch(
                padding: const EdgeInsets.all(0),
                value: isOnlyYourAttempts.value,
                onChanged: (val) {
                  isOnlyYourAttempts.value = !isOnlyYourAttempts.value;
                  update(val);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
