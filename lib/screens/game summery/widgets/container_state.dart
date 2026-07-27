import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

class ContainerState extends StatelessWidget {
  final bool isWin;
  final List<String> names;
  final DateTime dateTime;
  const ContainerState({
    super.key,
    required this.names,
    required this.isWin,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 233,
      width: 360,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: isWin ? Colors.greenAccent : const Color(0xFFC14D4D),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isWin ? RemixIcons.trophy_fill : RemixIcons.close_fill,
              color: Colors.black,
              size: 35,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isWin ? "VICTORY!" : "DEFEAT!",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 36,
              color: const Color(0xFFDAB9FF),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat.yMMMEd().format(dateTime),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              color: const Color(0xFFE5E2E1),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  names[0],
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    color: const Color(0xFFE5E2E1),
                  ),
                ),
                Text(
                  names[1],
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    color: const Color(0xFFE5E2E1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
