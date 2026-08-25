import 'dart:async';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/screens/Splash%20Screen/Widgets/maintenance_dialog.dart';
import 'package:guess_duel/screens/Splash%20Screen/Widgets/update_dialog.dart';
import 'package:guess_duel/screens/offline%20game%20screens/offline%20home/offline_home_screen.dart';
import 'package:guess_duel/screens/sign_in/sign_in_screen.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/cubit/App%20Config/app_config_cubit.dart';
import 'package:guess_duel/pageview.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 1.0;
  Timer? _progressTimer;
  @override
  void initState() {
    super.initState();

    context.read<InternetCubit>().retryConnection();

    _startSimulatedProgress();
  }

  void _startSimulatedProgress() {
    final random = math.Random();
    _progressTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (_progress < 100) {
        setState(() {
          _progress += random.nextDouble() * 4.5;
          if (_progress > 100) {
            _progress = 100;
          }
        });
      } else {
        _progressTimer?.cancel();
        _checkConfigAndNavigate();
      }
    });
  }

  Future<void> _checkConfigAndNavigate() async {
    // check for internet connection

    if (!await context.read<InternetCubit>().hasInternet()) {
      Get.offAll(() => const OfflineHomeScreen());
      return;
    }
    if (!mounted) return;

    // get appConfig from firebase

    final configCubit = context.read<AppConfigCubit>();
    await configCubit.getAppConfig();

    if (!mounted) return;

    // 1. Check Maintenance state
    if (configCubit.checkMaintenance()) {
      _showMaintenanceDialog();
      return;
    }
    // 2. Check Force Update state
    if (configCubit.checkForceUpdate()) {
      _showUpdateDialog(configCubit.getUpdateUrl());
      return;
    }
    // 3. Complete navigation
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    final userId = SharedPrefService.getId();
    final User? user = FirebaseAuth.instance.currentUser;
    if (userId != null && user != null) {
      FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(userId)
          .update({"lastSeen": FieldValue.serverTimestamp()});

      Get.offAll(() => const Pages());
    } else if (userId != null) {
      // TODO : navigate to offline screen
      Get.offAll(() => const Pages());
    } else {
      Get.offAll(() => const SignInScreen());
    }
  }

  void _showMaintenanceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const MaintenanceDialog();
      },
    );
  }

  void _showUpdateDialog(String updateUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return UpdateDialog(updateUrl: updateUrl);
      },
    );
  }

  // void _showNoInternetDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return const InternetDialog();
  //     },
  //   );
  // }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Spacer top for layout balance
              const SizedBox(height: 1),
              // Center Branding Section
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // videogame_asset icon (flat, no glow)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: const Icon(
                      Icons.videogame_asset,
                      color: Color(0xFF00F0FF),
                      size: 48,
                    ),
                  ),
                  // GUESS text (flat, no glow)
                  Text(
                    "GUESS",
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFDBFCFF),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8.4,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // DUEL text (flat, no glow)
                  Text(
                    "DUEL",
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFDAB9FF),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 12.6,
                      height: 1.1,
                    ),
                  ),
                  // Technical Accent (flat, simple lines)
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 48,
                        color: const Color(0xFF00F0FF).withValues(alpha: 0.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "TACTICAL NEURAL LINK",
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(
                              0xFF00F0FF,
                            ).withValues(alpha: 0.5),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 5.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 48,
                        color: const Color(0xFF00F0FF).withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ],
              ),
              // Bottom Progress Section
              Container(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (_progress < 90)
                              ? "INITIALIZING..."
                              : "SEARCHING FOR UPDATES...",
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(
                              0xFF00F0FF,
                            ).withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          "${_progress.toInt()}%",
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(
                              0xFF00F0FF,
                            ).withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      children: [
                        // Progress bar track background
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        // Progress bar track fill (flat, no glow)
                        AnimatedFractionallySizedBox(
                          duration: const Duration(milliseconds: 800),
                          alignment: Alignment.centerLeft,
                          widthFactor: _progress / 100.0,
                          child: Container(
                            height: 2,
                            color: const Color(0xFF00F0FF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
