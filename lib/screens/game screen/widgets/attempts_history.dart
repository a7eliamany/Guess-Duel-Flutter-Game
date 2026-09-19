import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_duel/Widgets/text.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/cubit/Attempts/attempts_cubit.dart';
import 'package:guess_duel/cubit/Attempts/attempts_state.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_cubit.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/screens/game%20screen/widgets/history_title.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';
import 'package:remixicon/remixicon.dart';

class AttemptsHistory extends HookWidget {
  final String roomId;
  const AttemptsHistory({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final RoomPlayerCache playerData = HiveService.playersBox.get(
      HiveBoxPlayers.currentPlayer(roomId),
    );
    final RoomPlayerCache opponentData = HiveService.playersBox.get(
      HiveBoxPlayers.opponentPlayer(roomId),
    );
    final isOnlyYourAttempts = useState(false);
    return Column(
      children: [
        // History Section
        HistoryTitle(
          roomID: roomId,
          update: (val) {
            isOnlyYourAttempts.value = val;
          },
        ),
        Divider(color: const Color(0xFF767575).withValues(alpha: 0.1)),
        BlocBuilder<AttemptsCubit, AttemptsState>(
          builder: (context, state) {
            if (state is AttemptsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AttemptsLoaded) {
              if (state.attempts.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      RemixIcons.draft_line,
                      size: 100,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        'No attempts yet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              }

              List<AttemptModel> attempts = state.attempts;
              if (isOnlyYourAttempts.value) {
                attempts = attempts
                    .where((e) => e.userId == SharedPrefService.getId())
                    .toList();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: attempts.length,
                  itemBuilder: (context, index) {
                    final userID = SharedPrefService.getId();
                    AttemptModel attempt = attempts[index];
                    bool isYourAttempt = attempt.userId == userID;

                    return Column(
                      children: [
                        Align(
                          alignment: isYourAttempt
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isYourAttempt)
                                CircleAvatar(
                                  child: SvgPicture.asset(
                                    AppAvatars.getAvatarById(
                                      opponentData.avatarID,
                                    ).assetPath,
                                  ),
                                ),
                              const SizedBox(width: 18),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: isYourAttempt
                                      ? const Color(0xFF1a1a1a)
                                      : const Color(0xFF131313),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF767575).withValues(
                                      alpha: isYourAttempt ? 0.1 : 0.05,
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<NumpadCubit>().loadAttempt(
                                      attempt.attempt,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,

                                    // يعكس ترتيب العناصر
                                    textDirection: isYourAttempt
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,

                                    children: [
                                      // NUMBER
                                      Text(
                                        attempt.attempt,
                                        style: TextStyle(
                                          fontFamily: 'Space Grotesk',
                                          fontSize: 20,
                                          letterSpacing: 2,
                                          color: isYourAttempt
                                              ? Colors.white
                                              : Colors.white.withValues(
                                                  alpha: 0.6,
                                                ),
                                        ),
                                      ),

                                      const SizedBox(width: 20),

                                      // RESULT
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          if (attempt.correctNumbers > 0)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${attempt.correctNumbers} Correct',
                                                  style: TextStyle(
                                                    color: isYourAttempt
                                                        ? const Color(
                                                            0xFFa9ffac,
                                                          )
                                                        : const Color(
                                                            0xFFa9ffac,
                                                          ).withValues(
                                                            alpha: 0.6,
                                                          ),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),

                                                const SizedBox(width: 4),

                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                    attempt.correctNumbers,
                                                    (i) => Container(
                                                      width: 6,
                                                      height: 6,
                                                      margin:
                                                          const EdgeInsets.only(
                                                            right: 2,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: isYourAttempt
                                                            ? const Color(
                                                                0xFFa9ffac,
                                                              )
                                                            : const Color(
                                                                0xFFa9ffac,
                                                              ).withValues(
                                                                alpha: 0.4,
                                                              ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          if (attempt.correctPlaces > 0)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${attempt.correctPlaces} positioned',
                                                  style: TextStyle(
                                                    color: isYourAttempt
                                                        ? const Color(
                                                            0xFFd674ff,
                                                          )
                                                        : const Color(
                                                            0xFFd674ff,
                                                          ).withValues(
                                                            alpha: 0.6,
                                                          ),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),

                                                const SizedBox(width: 4),

                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                    attempt.correctPlaces,
                                                    (i) => Container(
                                                      width: 6,
                                                      height: 6,
                                                      margin:
                                                          const EdgeInsets.only(
                                                            right: 2,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: isYourAttempt
                                                            ? const Color(
                                                                0xFFd674ff,
                                                              )
                                                            : const Color(
                                                                0xFFd674ff,
                                                              ).withValues(
                                                                alpha: 0.4,
                                                              ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          if (attempt.correctNumbers < 1 &&
                                              attempt.correctPlaces < 1)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 12,
                                                  width: 1,
                                                  color: const Color(
                                                    0xFF767575,
                                                  ).withValues(alpha: 0.2),
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                      ),
                                                ),

                                                Text(
                                                  '4 Wrong',
                                                  style: TextStyle(
                                                    color: isYourAttempt
                                                        ? Colors.red
                                                        : Colors.red.withValues(
                                                            alpha: 0.6,
                                                          ),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),

                                                const SizedBox(width: 4),

                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                    4,
                                                    (i) => Container(
                                                      width: 6,
                                                      height: 6,
                                                      margin:
                                                          const EdgeInsets.only(
                                                            right: 2,
                                                          ),
                                                      decoration:
                                                          const BoxDecoration(
                                                            color: Colors.red,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              if (isYourAttempt)
                                CircleAvatar(
                                  child: SvgPicture.asset(
                                    AppAvatars.getAvatarById(
                                      playerData.avatarID,
                                    ).assetPath,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              );
            } else if (state is AttemptsFailure) {
              return Center(child: CText(data: state.errorMsg, size: 30));
            } else {
              return const Text("");
            }
          },
        ),
      ],
    );
  }
}
