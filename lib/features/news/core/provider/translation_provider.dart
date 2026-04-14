
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/translation_service.dart';
final translationServiceProvider = Provider<TranslationService>((ref) {
  return TranslationService();
});