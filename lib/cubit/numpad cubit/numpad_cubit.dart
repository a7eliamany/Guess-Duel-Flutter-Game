import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_state.dart';

class NumpadCubit extends Cubit<NumpadState> {
  static const int maxDigits = 4;

  NumpadCubit()
    : super(
        NumpadState(code: '_' * maxDigits, index: 0, isReadyToSubmit: false),
      );

  void onKeyPress(String key, {int? targetIndex}) {
    if (key == 'backspace') {
      onBackspacePressed();
      return;
    }

    onNumberPressed(digit: key, targetIndex: targetIndex);
  }

  void onNumberPressed({required String digit, int? targetIndex}) {
    final idx = targetIndex ?? state.index;

    // Invalid index
    if (idx < 0 || idx >= maxDigits) return;

    // Prevent duplicate digits
    final existingIndex = state.code.indexOf(digit);
    if (existingIndex != -1 && existingIndex != idx) return;

    final chars = state.code.split('');
    chars[idx] = digit;
    final newCode = chars.join('');
    final nextIndex = idx + 1 < maxDigits ? idx + 1 : idx;
    final isReady = !newCode.contains('_');

    emit(
      state.copyWith(code: newCode, index: nextIndex, isReadyToSubmit: isReady),
    );
  }

  void onBackspacePressed() {
    final idx = state.index;

    if (idx < 0 || idx >= maxDigits) return;

    final chars = state.code.split('');

    // Current position has a digit → delete it and stay on the same index
    if (chars[idx] != '_') {
      chars[idx] = '_';
      emit(
        state.copyWith(
          code: chars.join(''),
          index: idx,
          isReadyToSubmit: false,
        ),
      );
      return;
    }

    // Current position is empty → move to previous and delete
    if (idx > 0) {
      final previousIndex = idx - 1;
      chars[previousIndex] = '_';
      emit(
        state.copyWith(
          code: chars.join(''),
          index: previousIndex,
          isReadyToSubmit: false,
        ),
      );
    }
  }

  void loadAttempt(String input) {
    emit(
      state.copyWith(
        code: input,
        index: input.length - 1,
        isReadyToSubmit: true,
      ),
    );
  }

  void updateIndex(int index) {
    if (index < 0 || index >= maxDigits) return;
    emit(state.copyWith(index: index));
  }

  void clearCode() {
    emit(
      state.copyWith(code: '_' * maxDigits, index: 0, isReadyToSubmit: false),
    );
  }
}
