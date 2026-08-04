import 'package:flutter/material.dart';
import 'package:guess_duel/screens/History%20screen/history_screen.dart';
import 'package:guess_duel/screens/offline%20game%20screens/create_offline_game/offline_create_bs.dart';
import 'widgets/offline_bottom_nav.dart';
import 'widgets/offline_header.dart';
import 'widgets/offline_status_section.dart';
import 'widgets/reconnect_section.dart';
import 'widgets/solo_challenge_card.dart';

class OfflineHomeScreen extends StatefulWidget {
  const OfflineHomeScreen({super.key});

  @override
  State<OfflineHomeScreen> createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  OfflineNavTab _currentTab = OfflineNavTab.home;
  List<Widget> pages = const [OfflineHomeScreen(), HistoryScreen()];

  void _onStartOfflineGame() {
    OfflineCreateBs.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F131E),
      body: Stack(
        children: [
          // Main Body with Header, Scrollable Content & Bottom Nav
          SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: [
                if (_currentTab == OfflineNavTab.home) const OfflineHeader(),
                _currentTab == OfflineNavTab.history
                    ? const Expanded(child: HistoryScreen())
                    : Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 24,
                          ),
                          children: [
                            const OfflineStatusSection(),
                            const SizedBox(height: 16),
                            SoloChallengeCard(onStartGame: _onStartOfflineGame),
                            const SizedBox(height: 24),
                            const ReconnectSection(),
                          ],
                        ),
                      ),

                OfflineBottomNav(
                  currentTab: _currentTab,
                  onTabSelected: (tab) {
                    setState(() {
                      _currentTab = tab;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
