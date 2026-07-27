import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Secret%20number/secret_number_cubit.dart';

class ConfirmNumberButton extends StatelessWidget {
  final String roomID;
  const ConfirmNumberButton({super.key, required this.roomID});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SecretNumberCubit>();
    return ElevatedButton(
      onPressed: () {
        cubit.confirm(roomID);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC3F5FF),
        foregroundColor: const Color(0xFF00363D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 50),
        shadowColor: const Color(0xFFC3F5FF).withValues(alpha: 0.1),
        elevation: 8,
      ),
      child: const Text(
        'Confirm Number',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}
