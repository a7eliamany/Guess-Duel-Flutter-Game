import 'package:get_it/get_it.dart';
import 'package:guess_duel/cubit/Create%20game/create_game_cubit.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_cubit.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';

class ServiceLocator {
  static final getIt = GetIt.instance;
  static void setup() {
    getIt.registerLazySingleton<InternetCubit>(() => InternetCubit());

    getIt.registerFactory<CreateRoomCubit>(
      () => CreateRoomCubit(getIt<InternetCubit>()),
    );
    getIt.registerFactory<JoinRoomCubit>(
      () => JoinRoomCubit(getIt<InternetCubit>()),
    );
  }
}
