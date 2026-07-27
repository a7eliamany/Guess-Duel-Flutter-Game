import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';
import 'package:guess_duel/cubit/History/historty_state.dart';
import 'package:guess_duel/cubit/History/history_cubit.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/screens/game%20summery/game_summery_screen.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'widgets/history_header.dart';
import 'widgets/stats_row.dart';
import 'widgets/game_history_tile.dart';
import 'widgets/end_of_records.dart';

class HistoryScreen extends HookWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<HistoryCubit>().getHistory();
      return null;
    }, []);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            // — Header
            const HistoryHeader(),

            const SizedBox(height: 28),

            // — Stats Row
            BlocBuilder<HistoryCubit, HistortyState>(
              builder: (context, state) {
                final fakeHistory = List.generate(
                  2,
                  (index) => GameHistoryModel(
                    roomID: 'ROOM-0000',
                    isWin: index == 1 ? false : true,
                    dateTime: DateTime.now(),
                    attemptsModel: [],
                    players: [],
                  ),
                );

                final bool isLoading = state is HistoryLoading;

                final history = isLoading
                    ? fakeHistory
                    : (state as HistortyLoaded).history;
                return Skeletonizer(
                  enabled: isLoading,
                  child: Column(
                    children: [
                      StatsRow(
                        gamesPlayed: isLoading
                            ? 99
                            : (state as HistortyLoaded).status.gamesPlayed,
                        wins: isLoading
                            ? 99
                            : (state as HistortyLoaded).status.wins,
                        winRate: isLoading
                            ? "100%"
                            : "${(state as HistortyLoaded).status.winRate} %",
                      ),

                      const SizedBox(height: 32),

                      // — Section Title
                      _buildSectionTitle(context),

                      const SizedBox(height: 16),

                      // — Game History List
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          final GameHistoryModel gameHistoryModel =
                              history[index];
                          GameResult gameResult = (gameHistoryModel.isWin)
                              ? GameResult.victory
                              : GameResult.defeat;

                          return Column(
                            children: [
                              GameHistoryTile(
                                onTap: () {
                                  Get.to(
                                    GameSummeryScreen(
                                      gameHistoryModel: gameHistoryModel,
                                    ),
                                  );
                                },
                                result: gameResult,
                                date: DateFormat.yMd().format(
                                  gameHistoryModel.dateTime,
                                ),
                                attempts: gameHistoryModel.attemptsModel.length
                                    .toString(),

                                gameId: gameHistoryModel.roomID,
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      ),

                      // — End of Records
                      const EndOfRecords(),
                    ],
                  ),
                );

                // if (state is HistoryLoading) {
                //   return const Center(child: LoadingWidget());
                // } else if (state is HistortyLoaded) {
                //   return ListView(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 16,
                //       vertical: 16,
                //     ),
                //     children: [
                //       // — Header
                //       const HistoryHeader(),

                //       const SizedBox(height: 28),

                //       // — Stats Row
                //       StatsRow(
                //         gamesPlayed: state.status.gamesPlayed,
                //         wins: state.status.wins,
                //         winRate: ('${state.status.winRate} %'),
                //       ),

                //       const SizedBox(height: 32),

                //       // — Section Title
                //       _buildSectionTitle(context),

                //       const SizedBox(height: 16),

                //       // — Game History List
                //       ListView.builder(
                //         physics: const NeverScrollableScrollPhysics(),
                //         shrinkWrap: true,
                //         itemCount: state.history.length,
                //         itemBuilder: (context, index) {
                //           final GameHistoryModel gameHistoryModel =
                //               state.history[index];
                //           GameResult gameResult = (gameHistoryModel.isWin)
                //               ? GameResult.victory
                //               : GameResult.defeat;

                //           return Column(
                //             children: [
                //               GameHistoryTile(
                //                 onTap: () {
                //                   Get.to(
                //                     GameSummeryScreen(
                //                       gameHistoryModel: gameHistoryModel,
                //                     ),
                //                   );
                //                 },
                //                 result: gameResult,
                //                 date: DateFormat.yMd().format(
                //                   gameHistoryModel.dateTime,
                //                 ),
                //                 attempts: gameHistoryModel.attemptsModel.length
                //                     .toString(),

                //                 gameId: gameHistoryModel.roomID,
                //               ),
                //               const SizedBox(height: 12),
                //             ],
                //           );
                //         },
                //       ),

                //       // — End of Records
                //       const EndOfRecords(),
                //     ],
                //   );
                // } else if (state is HistortyError) {
                //   return Center(child: Text(state.error));
                // }
                // return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'RECENT ENCOUNTERS',
          style: TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // TODO: implement filter logic
              },
              child: Text(
                'Filter List',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {
                context.read<HistoryCubit>().clearGameHistory();
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
