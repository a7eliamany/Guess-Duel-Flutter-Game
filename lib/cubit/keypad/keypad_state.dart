class KeypadState {
  final String input;
  final int index;
  final int maxDigits;
  final bool allowDuplicates;
  final bool isReadyToSubmit;

  const KeypadState({
    required this.input,
    required this.index,
    required this.maxDigits,
    this.allowDuplicates = false,
    required this.isReadyToSubmit,
  });

  bool get isComplete {
    final clean = input.replaceAll('_', '');
    return clean.length == maxDigits;
  }

  bool get isEmpty {
    final clean = input.replaceAll('_', '');
    return clean.isEmpty;
  }

  String get cleanInput => input.replaceAll('_', '');

  KeypadState copyWith({
    String? input,
    int? index,
    int? maxDigits,
    bool? allowDuplicates,
    bool? isReadyToSubmit,
  }) {
    return KeypadState(
      input: input ?? this.input,
      index: index ?? this.index,
      maxDigits: maxDigits ?? this.maxDigits,
      allowDuplicates: allowDuplicates ?? this.allowDuplicates,
      isReadyToSubmit: isReadyToSubmit ?? this.isReadyToSubmit,
    );
  }
}
