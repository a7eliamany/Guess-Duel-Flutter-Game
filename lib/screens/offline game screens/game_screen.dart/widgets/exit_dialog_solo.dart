import 'package:flutter/material.dart';
import 'package:guess_duel/Widgets/app_dialog.dart';

Future<bool> soloExitDialog({required BuildContext context}) async {
  bool? result;
  await AppDialog.show(
    context: context,
    title: "Exit Game?",
    message:
        "Are you sure you want to exit the game? All progress will be lost.",
    icon: Icons.exit_to_app,
    canPop: true,

    accentColor: Colors.lightBlue,
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context, false);
          result = false;
        },
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context, true);
          result = true;
        },
        child: const Text("Exit"),
      ),
    ],
  );
  return result ?? false;
}
