class NumpadState {
  final String code;
  final int index;
  final bool isReadyToSubmit;

  NumpadState({
    required this.code,
    required this.index,
    required this.isReadyToSubmit,
  });

  NumpadState copyWith({String? code, int? index, bool? isReadyToSubmit}) {
    return NumpadState(
      code: code ?? this.code,
      index: index ?? this.index,
      isReadyToSubmit: isReadyToSubmit ?? this.isReadyToSubmit,
    );
  }
}
