import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../../state/translation_state.dart';
import 'translation_button.dart';

class NewsDescriptionSection extends StatefulWidget {
  final String displayDescription;
  final TranslationState translationState;
  final String newsId;
  final String title;
  final String des;

  const NewsDescriptionSection({
    required this.displayDescription,
    required this.translationState,
    required this.newsId,
    required this.title,
    required this.des,
    Key? key,
  }) : super(key: key);

  @override
  State<NewsDescriptionSection> createState() =>
      _NewsDescriptionSectionState();
}

class _NewsDescriptionSectionState extends State<NewsDescriptionSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.translationState.isTranslated ? "الوصف:" : "Description:",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.displayDescription,
          textDirection: widget.translationState.isTranslated
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          maxLines: isExpanded ? null : 4,
          overflow:
          isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.8),
            height: 1.5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  isExpanded
                      ? (widget.translationState.isTranslated
                      ? "عرض أقل"
                      : "Show Less")
                      : (widget.translationState.isTranslated
                      ? "اقرأ المزيد..."
                      : "Read More..."),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TranslationButton(
              translationState: widget.translationState,
              newsId: widget.newsId,
              title: widget.title,
              des: widget.des,
            ),
          ],
        ),
      ],
    );
  }
}