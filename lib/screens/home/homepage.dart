import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guess_duel/screens/home/widgets/create_game_button.dart';
import 'package:guess_duel/screens/home/widgets/game_code_section.dart';
import 'package:guess_duel/screens/home/widgets/home_header.dart';
import 'package:guess_duel/screens/home/widgets/join_game_button.dart';
import 'package:guess_duel/screens/home/widgets/offline_button.dart';

class Homepage extends HookWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCodeKey = useMemoized(() => GlobalKey<FormState>());
    final codeController = useTextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         context.read<SigninCubit>().signOut();
      //       },
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const HomeHeader(),
            const SizedBox(height: 56),
            GameCodeSection(
              codeController: codeController,
              gameCodeKey: gameCodeKey,
            ),
            const SizedBox(height: 30),
            JoinGameButton(
              codeController: codeController,
              gameCodeKey: gameCodeKey,
            ),
            const SizedBox(height: 16),
            const CreateGameButton(),
            const SizedBox(height: 16),
            const OfflineButton(),
          ],
        ),
      ),
    );
  }
}
