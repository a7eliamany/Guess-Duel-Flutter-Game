import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Widgets/text.dart';
import 'package:guess_duel/cubit/Attempts/attempts_cubit.dart';
import 'package:guess_duel/cubit/Attempts/attempts_state.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';

import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class AttemptsHistory extends StatelessWidget {
  const AttemptsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AttemptsCubit, AttemptsState>(
          builder: (context, state) {
            if (state is AttemptsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AttemptsLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.attempts.length,
                itemBuilder: (context, index) {
                  final userID = SharedPrefService.getId();
                  AttemptModel attempt = state.attempts[index];
                  bool isYourAttempt = attempt.userId == userID;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isYourAttempt
                          ? const Color(0xFF1a1a1a)
                          : const Color(0xFF131313),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(
                          0xFF767575,
                        ).withValues(alpha: isYourAttempt ? 0.1 : 0.05),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          attempt.attempt,
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 20,
                            letterSpacing: 2,
                            color: isYourAttempt
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        Row(
                          children: [
                            if (attempt.correctNumbers > 0)
                              Row(
                                children: [
                                  Text(
                                    '${attempt.correctNumbers} Correct',
                                    style: TextStyle(
                                      color: isYourAttempt
                                          ? const Color(0xFFa9ffac)
                                          : const Color(
                                              0xFFa9ffac,
                                            ).withValues(alpha: 0.6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Row(
                                    children: List.generate(
                                      attempt.correctNumbers,
                                      (i) => Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(right: 2),
                                        decoration: BoxDecoration(
                                          color: isYourAttempt
                                              ? const Color(0xFFa9ffac)
                                              : const Color(
                                                  0xFFa9ffac,
                                                ).withValues(alpha: 0.4),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (attempt.correctPlaces > 0)
                              Row(
                                children: [
                                  Container(
                                    height: 12,
                                    width: 1,
                                    color: const Color(
                                      0xFF767575,
                                    ).withValues(alpha: 0.2),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                  Text(
                                    '${attempt.correctPlaces} postioned',
                                    style: TextStyle(
                                      color: isYourAttempt
                                          ? const Color(0xFFd674ff)
                                          : const Color(
                                              0xFFd674ff,
                                            ).withValues(alpha: 0.6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Row(
                                    children: List.generate(
                                      attempt.correctPlaces,
                                      (i) => Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(right: 2),
                                        decoration: BoxDecoration(
                                          color: isYourAttempt
                                              ? const Color(0xFFd674ff)
                                              : const Color(
                                                  0xFFd674ff,
                                                ).withValues(alpha: 0.4),
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
                                children: [
                                  Container(
                                    height: 12,
                                    width: 1,
                                    color: const Color(
                                      0xFF767575,
                                    ).withValues(alpha: 0.2),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                  Text(
                                    '4 Wrong',
                                    style: TextStyle(
                                      color: isYourAttempt
                                          ? Colors.red
                                          : Colors.red.withValues(alpha: 0.6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Row(
                                    children: List.generate(
                                      4,
                                      (i) => Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(right: 2),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
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
                  );
                },
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
