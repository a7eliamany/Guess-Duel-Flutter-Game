import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';

Future<bool> ensureInternet(BuildContext context) async {
  final internetCubit = context.read<InternetCubit>();

  final hasNet = await internetCubit.hasInternet();

  if (!hasNet) {
    Get.snackbar("No Internet", "Check your connection");
  }

  return hasNet;
}
