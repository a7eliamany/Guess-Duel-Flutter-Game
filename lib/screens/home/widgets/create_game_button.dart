import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Widgets/glow_button.dart';
import 'package:guess_duel/cubit/Create%20game/create_game_cubit.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/screens/create_game/create_game_bottomsheet.dart';
import 'package:guess_duel/services/Get%20It/service_locater.dart';
import 'package:remixicon/remixicon.dart';

class CreateGameButton extends StatelessWidget {
  const CreateGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GlowButton(
      color: colorScheme.primary,
      textColor: colorScheme.onPrimary,
      text: "CREATE NEW GAME",
      icon: RemixIcons.add_box_fill,
      isEnabled: true,
      onPressed: () async {
        showModalBottomSheet(
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          context: context,
          builder: (_) => BlocProvider(
            create: (context) =>
                CreateRoomCubit(ServiceLocator.getIt<InternetCubit>()),

            child: const CreateGameBottomsheet(),
          ),
        );
      },
    );
  }
}
