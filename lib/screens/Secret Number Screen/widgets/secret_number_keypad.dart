import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Secret%20number/secret_number_cubit.dart';

class SecretNumberKeypad extends StatelessWidget {
  const SecretNumberKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SecretNumberCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        mainAxisExtent: 60,
        childAspectRatio: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 1; i <= 9; i++)
            ElevatedButton(
              onPressed: () => cubit.onKeyPress(i.toString()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E0E0E),
                foregroundColor: const Color(0xFFE5E2E1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(80, 56),
              ),
              child: Text(
                i.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),
            ),

          IconButton(
            onPressed: () => cubit.onKeyPress('backspace'),
            icon: const Icon(Icons.backspace, color: Colors.red),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF0E0E0E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(80, 56),
            ),
          ),

          ElevatedButton(
            onPressed: () => cubit.onKeyPress('0'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E0E0E),
              foregroundColor: const Color(0xFFE5E2E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(80, 56),
            ),
            child: const Text(
              '0',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Manrope',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
