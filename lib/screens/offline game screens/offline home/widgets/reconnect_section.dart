import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/glow_button.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_state.dart';
import 'package:guess_duel/screens/Splash%20Screen/splash_screen.dart';

class ReconnectSection extends StatelessWidget {
  const ReconnectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF171B27).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: BlocBuilder<InternetCubit, InternetCheckState>(
        builder: (context, state) {
          final bool isConnected =
              state.internetConnectionState ==
              InternetConnectionState.connected;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isConnected ? 'CONNECTED!' : 'RECONNECT',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFDFE2F2),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                isConnected
                    ? 'You can go to home screen and play online games.'
                    : 'Check your internet connection and restore online features.',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFB9CACB),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child:
                    GlowButton(
                          text: isConnected ? 'GO HOME' : 'RETRY CONNECTION',
                          isEnabled: !state.isLoading,
                          color: isConnected
                              ? const Color(0xFF0A6A9B)
                              : Colors.blueGrey,
                          icon: isConnected
                              ? Icons.arrow_forward
                              : Icons.refresh_rounded,
                          onPressed: () {
                            if (isConnected) {
                              Get.offAll(() => const SplashScreen());
                            } else {
                              context.read<InternetCubit>().retryConnection();
                            }
                          },
                          loadingText: "CONNECTING...",
                        )
                        .animate(
                          autoPlay: true,
                          onPlay: (controller) => controller.repeat(),
                        )
                        .shimmer(duration: 2.seconds),

                //  OutlinedButton(
                //   onPressed: _isConnecting ? null : _handleRetry,
                //   style:

                //    OutlinedButton.styleFrom(
                //     side: BorderSide(
                //       color: const Color(0xFF849495).withValues(alpha: 0.3),
                //     ),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(999),
                //     ),
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       RotationTransition(
                //         turns: _spinController,
                //         child: Icon(
                //           Icons.refresh_rounded,
                //           color: _hasError
                //               ? const Color(0xFFFFB4AB)
                //               : const Color(0xFFB9CACB),
                //           size: 20,
                //         ),
                //       ),
                //       const SizedBox(width: 8),
                //       Text(
                //         _isConnecting ? 'CONNECTING...' : 'RETRY CONNECTION',
                //         style: GoogleFonts.spaceGrotesk(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w600,
                //           color: _hasError
                //               ? const Color(0xFFFFB4AB)
                //               : const Color(0xFFDFE2F2),
                //           letterSpacing: 1.5,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ),
            ],
          );
        },
      ),
    );
  }
}
