class TranslationState {
  final bool isTranslating;
  final bool isTranslated;
  final String? translatedTitle;
  final String? translatedDescription;
  final String? error;

  const TranslationState({
    this.isTranslating = false,
    this.isTranslated = false,
    this.translatedTitle,
    this.translatedDescription,
    this.error,
  });

  factory TranslationState.initial() => const TranslationState();

  factory TranslationState.loading() => const TranslationState(
    isTranslating: true,
  );

  factory TranslationState.translated({
    required String title,
    required String description,
  }) =>
      TranslationState(
        isTranslated: true,
        translatedTitle: title,
        translatedDescription: description,
      );

  factory TranslationState.showOriginal({
    required String title,
    required String description,
  }) =>
      TranslationState(
        isTranslated: false,
        translatedTitle: title,
        translatedDescription: description,
      );

  factory TranslationState.error(String message) => TranslationState(
    error: message,
  );

  bool get hasCache =>
      translatedTitle != null && translatedDescription != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TranslationState &&
        other.isTranslating == isTranslating &&
        other.isTranslated == isTranslated &&
        other.translatedTitle == translatedTitle &&
        other.translatedDescription == translatedDescription &&
        other.error == error;
  }

  @override
  int get hashCode {
    return isTranslating.hashCode ^
    isTranslated.hashCode ^
    translatedTitle.hashCode ^
    translatedDescription.hashCode ^
    error.hashCode;
  }
}