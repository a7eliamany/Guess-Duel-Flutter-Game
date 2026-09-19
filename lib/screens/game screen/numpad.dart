import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_cubit.dart';

class Button {
  final String value;
  final void Function() onTap;
  factory Button.create({
    required String value,
    required Function(String val) onTap,
  }) {
    return Button(value: value, onTap: () => onTap(value));
  }
  const Button({required this.value, required this.onTap});
}

class Numpad extends StatelessWidget {
  const Numpad({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Button> buttons = List.generate(9, (i) {
      return Button.create(
        value: (i + 1).toString(),
        onTap: (val) {
          context.read<NumpadCubit>().onKeyPress(val);
        },
      );
    });
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      mainAxisExtent: 80,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,

      children: [
        for (final button in buttons) ButtonWidget(button: button),

        SpecialButtonWidget(
          specialButton: Button.create(
            value: "backspace",
            onTap: (val) {
              context.read<NumpadCubit>().onKeyPress(val);
            },
          ),
        ),
        ButtonWidget(
          button: Button.create(
            value: "0",
            onTap: (val) {
              context.read<NumpadCubit>().onKeyPress(val);
            },
          ),
        ),
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final Button button;
  const ButtonWidget({super.key, required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: button.onTap,
        child: Center(
          child: Text(
            button.value,
            style: const TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialButtonWidget extends StatelessWidget {
  final Button specialButton;
  const SpecialButtonWidget({super.key, required this.specialButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: specialButton.onTap,
        child: Center(
          child: Icon(
            Icons.backspace,
            color: const Color(0xFFff716c).withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}
