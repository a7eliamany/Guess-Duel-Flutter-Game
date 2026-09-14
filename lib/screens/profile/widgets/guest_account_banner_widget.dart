import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/scale_on_press_button.dart';
import 'package:guess_duel/cubit/sign%20in/sign_in_cubit.dart';
import 'package:guess_duel/cubit/sign%20in/sign_in_state.dart';

/// Guest warning card and action buttons ("Create Account" / "Log Out").
class GuestAccountBannerWidget extends StatelessWidget {
  final VoidCallback? onCreateAccount;
  final VoidCallback? onLogout;

  const GuestAccountBannerWidget({
    super.key,
    this.onCreateAccount,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    const surfaceContainerHigh = Color(0xFF262A36);

    const primaryCyan = Color(0xFF00F0FF);
    const primaryFixedDim = Color(0xFF00DBE9);
    const onPrimary = Color(0xFF00363A);
    const secondaryFixed = Color(0xFFD9E2FF);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Guest Warning Card
        BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            final bool isGuest = state is SignOut;
            if (isGuest) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          color: secondaryFixed,
                          size: 28,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Playing as Guest',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Your progress is currently saved only on this device. Create an account to sync.',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Create Account Button
                  ScaleOnPressButton(
                    onPressed: onCreateAccount,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: primaryCyan,
                        borderRadius: BorderRadius.circular(12),
                        border: const Border(
                          bottom: BorderSide(
                            color: primaryFixedDim,
                            width: 3.5,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryCyan.withValues(alpha: 0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'CREATE ACCOUNT',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),

        // Log Out Button
        BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            final bool isGuest = state is SignOut;
            return !isGuest
                ? ScaleOnPressButton(
                    onPressed: onLogout,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'LOG OUT',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
