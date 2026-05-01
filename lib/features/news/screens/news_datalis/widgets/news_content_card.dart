import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../../model/news_model.dart';
import '../../../state/translation_state.dart';
import 'action_row.dart';
import 'likes_and_views.dart';
import 'news_category_row.dart';
import 'news_description_section.dart';

class NewsContentCard extends StatelessWidget {
  final NewsModel news;
  final TranslationState translationState;
  final String displayTitle;
  final String displayDescription;

  const NewsContentCard({
    required this.news,
    required this.translationState,
    required this.displayTitle,
    required this.displayDescription,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayTitle,
              textDirection: translationState.isTranslated
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            NewsCategoryRow(
              category: news.category,
              createdAt: news.createdAt,
            ),
            const SizedBox(height: 20),

            NewsDescriptionSection(
              displayDescription: displayDescription,
              translationState: translationState,
              newsId: news.newsId,
              title: news.title,
              des: news.des,
            ),
            const Divider(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikesAndViewsRow(news: news, like: null),
                ActionsRow(news: news),
              ],
            ),
          ],
        ),
      ),
    );
  }
}