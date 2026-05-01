import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/vm/translation_viewmodel_provider.dart';
import '../../../state/translation_state.dart';


class TranslationButton extends ConsumerWidget {
  final TranslationState translationState;
  final String newsId;
  final String title;
  final String des;

  const TranslationButton({
    required this.translationState,
    required this.newsId,
    required this.title,
    required this.des,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: translationState.isTranslating
          ? null
          : () {
        ref
            .read(translationViewModelProvider(newsId).notifier)
            .toggleTranslation(
          title: title,
          description: des,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: translationState.isTranslating
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 6),
            Text(
              "جاري الترجمة...",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
            : Text(
          translationState.isTranslated
              ? "النص الأصلي"
              : "الترجمة إلى العربية",
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}