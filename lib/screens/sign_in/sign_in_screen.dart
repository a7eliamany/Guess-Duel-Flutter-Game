import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guess_duel/cubit/SignIn/signin_cubit.dart';
import 'package:guess_duel/cubit/SignIn/signin_state.dart';
import 'package:guess_duel/pageview.dart';
import 'package:guess_duel/screens/sign_in/widgets/atmospheric_background.dart';
import 'package:guess_duel/screens/sign_in/widgets/feature_item.dart';
import 'package:guess_duel/screens/sign_in/widgets/sign_in_form.dart';
import 'package:guess_duel/screens/sign_in/widgets/sign_in_header.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            Get.offAll(() => const Pages());
          } else if (state is SigninFailure) {
            Get.snackbar("Error", state.errorMessage);
          }
        },
        builder: (context, state) {
          final bool isLoading = state is SigninLoading;
          return Stack(
            children: [
              // Atmospheric Background
              const AtmosphericBackground(),

              // Main Sign In Contents
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SignInHeader(),
                        const SizedBox(height: 48),
                        SignInForm(
                          isLoading: isLoading,
                          onSignIn: (username) {
                            context.read<SigninCubit>().getStarted(username);
                          },
                        ),
                        const SizedBox(height: 48),
                        // Features Footer Grid
                        const Row(
                          children: [
                            Expanded(
                              child: FeatureItem(
                                icon: Icons.bolt,
                                label: "FAST DUEL",
                                iconColor: Color(0xFFD4BBFF),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: FeatureItem(
                                icon: Icons.groups,
                                label: "SOCIAL PLAY",
                                iconColor: Color(0xFFFFEAC0),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: FeatureItem(
                                icon: Icons.emoji_events,
                                label: "LEADERBOARDS",
                                iconColor: Color(0xFFC3F5FF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
