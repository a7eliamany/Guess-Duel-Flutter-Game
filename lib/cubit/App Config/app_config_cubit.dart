import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/app_version.dart';
import 'package:guess_duel/models/app_config_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';

class AppConfigCubit extends Cubit<AppConfig> {
  AppConfigCubit()
    : super(AppConfig(minBuildNumber: 0, maintenance: false, updateUrl: ""));

  Future<void> getAppConfig() async {
    try {
      final AppConfig appConfig = await FirebaseService.getAppConfig();
      emit(appConfig);
    } catch (_) {}
  }

  bool checkMaintenance() {
    return state.maintenance;
  }

  bool checkForceUpdate() {
    const int buildNumber = AppVersion.buildNumber;
    return buildNumber < state.minBuildNumber;
  }

  String getUpdateUrl() {
    return state.updateUrl;
  }
}
