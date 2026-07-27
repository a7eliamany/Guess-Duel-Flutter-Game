import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    debugPrint("Create : ${bloc.runtimeType}");

    super.onCreate(bloc);
  }

  //@override
  // void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
  //   debugPrint("Change : ${bloc.runtimeType}");
  //   super.onChange(bloc, change);
  // }
  // @override
  // void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
  //   debugPrint("Error : ${bloc.runtimeType}");
  //   super.onError(bloc, error, stackTrace);
  // }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    debugPrint("Close : ${bloc.runtimeType}");
    super.onClose(bloc);
  }
}
