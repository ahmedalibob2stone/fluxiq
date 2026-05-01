import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/screens/news_datalis/widgets/news_content_card.dart';
import 'package:fluxiq/features/news/screens/news_datalis/widgets/news_header_image.dart';

import '../../../views/provider/vm/new_view_viewmodel_provider.dart';
import '../../model/news_model.dart';
import '../../provider/vm/translation_viewmodel_provider.dart';
import 'listeners/news_details_listeners.dart';
import 'widgets/news_details_app_bar.dart';
class NewsDetailsScreen extends ConsumerStatefulWidget {
  final NewsModel news;

  const NewsDetailsScreen({required this.news, Key? key}) : super(key: key);

  @override
  ConsumerState<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends ConsumerState<NewsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final viewModel =
      ref.read(newsViewsProvider(widget.news.newsId).notifier);
      viewModel.initialize(widget.news.newsId);
      viewModel.addView(newsId: widget.news.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.42;

    final viewsState = ref.watch(newsViewsProvider(widget.news.newsId));

    final translationState = ref.watch(
      translationViewModelProvider(widget.news.newsId),
    );

    final displayTitle = translationState.isTranslated
        ? (translationState.translatedTitle ?? widget.news.title)
        : widget.news.title;

    final displayDescription = translationState.isTranslated
        ? (translationState.translatedDescription ?? widget.news.des)
        : widget.news.des;

    return NewsDetailsListeners(
      newsId: widget.news.newsId,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: const NewsDetailsAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NewsHeaderImage(
                newsId: widget.news.newsId,
                imageUrl: widget.news.imageUrl,
                height: imageHeight,
              ),
              NewsContentCard(
                news: widget.news,
                translationState: translationState,
                displayTitle: displayTitle,
                displayDescription: displayDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
