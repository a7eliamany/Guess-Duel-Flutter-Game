import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_state.dart';

class OfflineStatusSection extends StatelessWidget {
  const OfflineStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: BlocBuilder<InternetCubit, InternetCheckState>(
        builder: (context, state) {
          final bool isConnected =
              state.internetConnectionState ==
              InternetConnectionState.connected;
          return Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFF00F0FF,
                            ).withValues(alpha: 0.2),
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scale(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.4, 1.4),
                          duration: 1200.ms,
                          curve: Curves.easeOut,
                        )
                        .fadeOut(duration: 1200.ms, curve: Curves.easeOut),

                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF262A36),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Icon(
                        isConnected ? Icons.wifi : Icons.wifi_off_rounded,
                        size: 42,
                        color: const Color(0xFFB9CACB),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isConnected ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isConnected ? "YOU'RE ONLINE" : "YOU'RE OFFLINE",
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFDFE2F2),
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: isConnected
                    ? Text(
                        "You Now Can Play Online Games",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFB9CACB),
                          height: 1.6,
                        ),
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFB9CACB),
                            height: 1.6,
                          ),
                          children: [
                            const TextSpan(text: "You can continue playing "),
                            TextSpan(
                              text: "Solo Mode",
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFF00F0FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  " while offline. Connect to access multiplayer and cloud features.",
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
