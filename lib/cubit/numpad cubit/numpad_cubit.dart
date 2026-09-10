import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/numpad%20cubit/numpad_state.dart';

class NumpadCubit extends Cubit<NumpadState> {
  NumpadCubit() : super(NumpadState(code: "____", index: 0));

  void onKeyPress(String key) {
    if (key == 'backspace') {
      final newIndex = state.index - 1 < 0 ? 0 : state.index - 1;

      emit(
        NumpadState(
          code: state.code.replaceRange(state.index, state.index + 1, '_'),
          index: newIndex,
        ),
      );

      return;
    }

    if (state.index >= 4) return;

    // منع تكرار الرقم
    if (state.code.contains(key)) return;

    emit(
      NumpadState(
        code: state.code.replaceRange(state.index, state.index + 1, key),
        index: state.index == 3 ? 3 : state.index + 1,
      ),
    );
  }

  void clearCode() {
    emit(NumpadState(code: "____", index: 0));
  }

  void updateIndex(int index) {
    emit(NumpadState(code: state.code, index: index));
  }
}
