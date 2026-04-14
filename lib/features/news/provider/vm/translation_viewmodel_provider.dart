
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/provider/translation_provider.dart';
import '../../state/translation_state.dart';
import '../../viewmodel/translation_viewmodel.dart';

final translationViewModelProvider = StateNotifierProvider.autoDispose
    .family<TranslationViewModel, TranslationState, String>(
      (ref, newsId) {
    final translationService = ref.watch(translationServiceProvider);
    return TranslationViewModel(
      translationService: translationService,
    );
  },
);