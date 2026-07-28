import 'package:flutter_bloc/flutter_bloc.dart';
import 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit({int maxDigits = 4, bool allowDuplicates = false})
    : super(
        KeypadState(
          input: '_' * maxDigits,
          index: 0,
          maxDigits: maxDigits,
          allowDuplicates: allowDuplicates,
          isReadyToSubmit: false,
        ),
      );

  void onNumberPressed({required String digit, int? targetIndex}) {
    final idx = targetIndex ?? state.index;
    if (idx < 0 || idx >= state.maxDigits) {
      return;
    }

    if (!state.allowDuplicates) {
      final existingIndex = state.input.indexOf(digit);
      if (existingIndex != -1 && existingIndex != idx) {
        return; // digit already exists in another position
      }
    }

    List<String> chars = state.input.split('');
    while (chars.length < state.maxDigits) {
      chars.add('_');
    }

    chars[idx] = digit;
    final newInput = chars.join('');

    int nextIndex = (idx + 1 < state.maxDigits) ? idx + 1 : idx;

    if (newInput.replaceAll('_', '').length == state.maxDigits) {
      emit(
        state.copyWith(
          input: newInput,
          index: nextIndex,
          isReadyToSubmit: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          input: newInput,
          index: nextIndex,
          isReadyToSubmit: false,
        ),
      );
    }
  }

  void changeIndex(int index) {
    if (index >= 0 && index < state.maxDigits) {
      emit(state.copyWith(index: index));
    }
  }

  void onBackspacePressed() {
    if (state.index < 0 || state.index >= state.maxDigits) return;

    List<String> chars = state.input.split('');
    while (chars.length < state.maxDigits) {
      chars.add('_');
    }

    if (chars[state.index] != '_') {
      chars[state.index] = '_';
      emit(
        state.copyWith(
          input: chars.join(''),
          index: state.index,
          isReadyToSubmit: false,
        ),
      );
    } else if (state.index > 0) {
      final prevIndex = state.index - 1;
      chars[prevIndex] = '_';
      emit(state.copyWith(input: chars.join(''), index: prevIndex));
    }
  }

  void clearInput() {
    emit(
      state.copyWith(
        input: '_' * state.maxDigits,
        index: 0,
        isReadyToSubmit: false,
      ),
    );
  }

  void setMaxDigits(int maxDigits) {
    emit(
      state.copyWith(maxDigits: maxDigits, input: '_' * maxDigits, index: 0),
    );
  }

  void loadAttempt(String input, int maxDigits, int attemptLeft) {
    if (attemptLeft == 0) {
      return;
    }
    emit(
      state.copyWith(input: input, index: maxDigits - 1, isReadyToSubmit: true),
    );
  }
}
