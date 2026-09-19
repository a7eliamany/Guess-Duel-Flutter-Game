import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/app_dialog.dart';
import 'package:guess_duel/cubit/profile/profile_cubit.dart';
import 'package:guess_duel/cubit/profile/profile_state.dart';
import 'package:guess_duel/cubit/sign%20in/sign_in_cubit.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:remixicon/remixicon.dart';
import 'package:guess_duel/screens/profile/widgets/guest_account_banner_widget.dart';
import 'package:guess_duel/screens/profile/widgets/performance_snippets_widget.dart';
import 'package:guess_duel/screens/profile/widgets/profile_header_widget.dart';
import 'package:guess_duel/screens/profile/widgets/stats_grid_widget.dart';
import 'package:get/get.dart';
import 'package:guess_duel/screens/auth/create_account_screen.dart';

/// Main Profile Screen for Guess Duel.
/// Assembles ambient background glows, top glass app bar, modular profile sections,
/// and fixed glass bottom navigation bar.
class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const onSurface = Color(0xFFDFE2F2);
    final profileCubit = context.read<ProfileCubit>();
    // final profileState = context.select((ProfileCubit cubit) => cubit.state); // for study
    useEffect(() {
      profileCubit.getInitialValue();
      return null;
    }, []);

    final StatsModel statsModel =
        HiveService.statsBox.get("Stats") ?? StatsModel();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            // 2. Scrollable Body Content
            SafeArea(
              top: true,
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(
                        RemixIcons.sword_line,
                        size: 32,
                        color: Colors.orangeAccent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PROFILE',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Header / Avatar & Info
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return ProfileHeaderWidget(
                        username: state.username,
                        createdAt: state.createdAt,
                        avatarID: state.avatarID,
                        id: state.id,
                        isEditing: state.isEditing,
                        isLoading: state.isLoading,
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // Stats Grid (2x2)
                  StatsGridWidget(statsModel: statsModel),

                  const SizedBox(height: 15),

                  // Performance Snippets (Horizontal scrollable streak cards)
                  PerformanceSnippetsWidget(
                    currentStreak: statsModel.winStreak,
                    bestStreak: statsModel.bestWinStreak,
                  ),

                  const SizedBox(height: 5),

                  // Recent Performance Chart
                  Text.rich(
                    TextSpan(
                      text: 'Last ',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${statsModel.recentGames['recent games']} Games',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ': '),
                        TextSpan(
                          text: '${statsModel.recentGames['wins']} Wins',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' · '),
                        TextSpan(
                          text: '${statsModel.recentGames['losses']} Losses',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),

                  const SizedBox(height: 24),

                  // // Settings List
                  // ProfileSettingsListWidget(
                  //   onNotificationsTap: () {},
                  //   onSoundTap: () {},
                  //   onVibrationTap: () {},
                  //   onAppearanceTap: () {},
                  // ),

                  // const SizedBox(height: 24),

                  // Guest Account Banner & Buttons
                  GuestAccountBannerWidget(
                    onCreateAccount: () =>
                        Get.to(() => const CreateAccountScreen()),
                    onLogout: () async {
                      await AppDialog.show(
                        context: context,
                        title: "LOG OUT",
                        message:
                            """Are you Sure you want to log out , your game history will be deleted """,
                        icon: RemixIcons.logout_box_line,
                        accentColor: Colors.pink,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<SignInCubit>().logOut();
                            },
                            child: const Text("Sure"),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
