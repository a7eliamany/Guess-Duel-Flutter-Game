import 'package:flutter/material.dart';

class RoomCodeField extends StatelessWidget {
  final TextEditingController _codeController;
  final GlobalKey<FormState> _gameCodeKey;

  const RoomCodeField({
    super.key,
    required TextEditingController codeController,
    required GlobalKey<FormState> gameCodeKey,
  }) : _codeController = codeController,
       _gameCodeKey = gameCodeKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _gameCodeKey,
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textCapitalization: TextCapitalization.characters,
        autocorrect: false,
        enableSuggestions: false,
        onChanged: (value) {
          _codeController.value = _codeController.value.copyWith(
            text: value.toUpperCase(),
            selection: TextSelection.collapsed(offset: value.length),
          );
        },
        maxLength: 6,
        controller: _codeController,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return "";
          } else if (value.trim().length < 6) {
            return " ";
          } else {
            return null;
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          letterSpacing: 12,
        ),
        decoration: InputDecoration(
          counterStyle: const TextStyle(fontWeight: FontWeight.bold),
          hintText: "XXXXXX",
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 12,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        ),
      ),
    );
  }
}
