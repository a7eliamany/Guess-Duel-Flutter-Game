import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    bool isError = false,

    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
