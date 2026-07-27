import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_cubit.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_state.dart';

class CodeInput extends StatelessWidget {
  const CodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            context.read<NumpadCubit>().updateIndex(index);
          },
          child: BlocBuilder<NumpadCubit, NumpadState>(
            builder: (context, state) {
              return Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: state.index == index
                        ? const Color(0xFF8ff5ff)
                        : const Color(0xFF767575).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    state.code[index] == '_' ? '_' : state.code[index],
                    style: TextStyle(
                      color: state.code[index] == '_'
                          ? const Color(0xFF767575).withValues(alpha: 0.4)
                          : const Color(0xFF8ff5ff),
                      fontFamily: 'Space Grotesk',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
