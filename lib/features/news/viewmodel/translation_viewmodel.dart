
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/service/translation_service.dart';
import '../state/translation_state.dart';

class TranslationViewModel extends StateNotifier<TranslationState> {
  final TranslationService translationService;

  TranslationViewModel({
    required this.translationService,
  }) : super(const TranslationState());

  Future<void> toggleTranslation({
    required String title,
    required String description,
    String targetLang = 'ar',
  }) async {

    if (state.isTranslated) {
      state = TranslationState.showOriginal(
        title: state.translatedTitle!,
        description: state.translatedDescription!,
      );
      return;
    }

    if (state.hasCache) {
      state = TranslationState.translated(
        title: state.translatedTitle!,
        description: state.translatedDescription!,
      );
      return;
    }

    state = TranslationState.loading();

    try {
      final result = await translationService.translateNews(
        title: title,
        description: description,
        to: targetLang,
      );

      if (!mounted) return;

      state = TranslationState.translated(
        title: result.title,
        description: result.description,
      );
    } catch (e) {
      if (!mounted) return;

      state = TranslationState.error('فشلت الترجمة، حاول مرة أخرى');
    }
  }

  void reset() {
    state = const TranslationState();
  }
}