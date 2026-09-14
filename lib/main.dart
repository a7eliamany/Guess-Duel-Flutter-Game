import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:guess_duel/app..bloc_observer.dart';
import 'package:guess_duel/cubit/App%20Config/app_config_cubit.dart';
import 'package:guess_duel/cubit/Create%20offline%20game/create_offline_game_cubit.dart';
import 'package:guess_duel/cubit/History/history_cubit.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_cubit.dart';
import 'package:guess_duel/cubit/Rooms/rooms_cubit.dart';
import 'package:guess_duel/cubit/get%20started/get_started_cubit.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/cubit/navigation%20bottom%20bar/navigation_bottombar_cubit.dart';
import 'package:guess_duel/cubit/profile/profile_cubit.dart';
import 'package:guess_duel/cubit/profile/profile_state.dart';
import 'package:guess_duel/screens/Splash%20Screen/splash_screen.dart';
import 'package:guess_duel/services/Firebase/firebase_options.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Get%20It/service_locater.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';
import 'package:guess_duel/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  await HiveService.init();
  ServiceLocator.setup();

  Bloc.observer = AppBlocObserver();
  await FirebaseService.initialize(DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCubit()),
        BlocProvider(
          create: (context) =>
              GetStartedCubit(ServiceLocator.getIt<InternetCubit>()),
        ),

        BlocProvider(
          create: (context) =>
              JoinRoomCubit(ServiceLocator.getIt<InternetCubit>()),
        ),
        BlocProvider(create: (context) => NavigationBottombarCubit()),
        BlocProvider(create: (context) => RoomsCubit()),
        BlocProvider(create: (context) => AppConfigCubit()),
        BlocProvider(create: (context) => HistoryCubit()),
        BlocProvider(create: (context) => CreateOfflineGameCubit()),
        BlocProvider(
          create: (context) => ProfileCubit(
            ProfileState(createdAt: DateTime(2026).millisecondsSinceEpoch),
          ),
        ),
      ],
      child: GetMaterialApp(
        title: "Guess duel",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,

        home: const SplashScreen(),
      ),
    );
  }
}
