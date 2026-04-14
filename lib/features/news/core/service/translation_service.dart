
import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translate(String text, {String to = 'ar'}) async {
    if (text.trim().isEmpty) return text;

    try {
      final translation = await _translator.translate(text, to: to);
      return translation.text;
    } catch (e) {
      return text;
    }
  }

  Future<TranslatedNews> translateNews({
    required String title,
    required String description,
    String to = 'ar',
  }) async {
    try {
      final results = await Future.wait([
        translate(title, to: to),
        translate(description, to: to),
      ]);

      return TranslatedNews(
        title: results[0],
        description: results[1],
      );
    } catch (e) {
      return TranslatedNews(title: title, description: description);
    }
  }
}

class TranslatedNews {
  final String title;
  final String description;

  TranslatedNews({required this.title, required this.description});
}