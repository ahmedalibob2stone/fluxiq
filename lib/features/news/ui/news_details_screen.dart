
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../../core/provider/current_user_id_provider.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../../favorites/provider/favorites_viewmodel_provider.dart';
import '../../favorites/state/favorites_state.dart';
import '../../sharing/provider/vm/new_sharing_vm_provider.dart';
import '../../sharing/state/share_state.dart';
import '../../views/provider/vm/new_view_viewmodel_provider.dart';
import '../core/widgets/safe_cached_image.dart';
import '../model/news_model.dart';
import '../provider/vm/translation_viewmodel_provider.dart';
import '../state/translation_state.dart';
import 'widgets/action_row.dart';
import 'widgets/likes_and_views.dart';

class NewsDetailsScreen extends ConsumerStatefulWidget {
  final NewsModel news;

  const NewsDetailsScreen({required this.news, Key? key}) : super(key: key);

  @override
  ConsumerState<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends ConsumerState<NewsDetailsScreen> {
  bool isExpanded = false;



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
    final userId = ref.watch(currentUserIdProvider);

    final translationState = ref.watch(
      translationViewModelProvider(widget.news.newsId),
    );

    final displayTitle = translationState.isTranslated
        ? (translationState.translatedTitle ?? widget.news.title)
        : widget.news.title;

    final displayDescription = translationState.isTranslated
        ? (translationState.translatedDescription ?? widget.news.des)
        : widget.news.des;

    ref.listen<TranslationState>(
      translationViewModelProvider(widget.news.newsId),
          (previous, next) {
        if (next.error != null && next.error != previous?.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    ref.listen<ShareState>(shareViewModelProvider, (previous, next) {
      if (next.status == ShareStatus.success) {
        Navigator.pop(context);

        if (next.lastPlatform == "CopyLink") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Link copied to clipboard!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        ref.read(shareViewModelProvider.notifier).reset();
      } else if (next.status == ShareStatus.failure && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(shareViewModelProvider.notifier).reset();
      }
    });

    if (userId != null) {
      ref.listen<FavoritesState>(
        favoritesViewModelProvider(userId),
            (previous, next) {
          if (next.error != null && next.error != previous?.error) {
            FluxIQSnackBar.showError(context, next.error!);
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.news.newsId,
              child: SafeCachedImage(
                imageUrl: widget.news.imageUrl,
                width: double.infinity,
                height: imageHeight,
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            Transform.translate(
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

                    Row(
                      children: [
                        Text(
                          widget.news.category,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat.yMMMd().format(widget.news.createdAt),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      translationState.isTranslated
                          ? "الوصف:"
                          : "Description:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      displayDescription,
                      textDirection: translationState.isTranslated
                          ? ui.TextDirection.rtl
                          : ui.TextDirection.ltr,
                      maxLines: isExpanded ? null : 4,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
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
                          onTap: () =>
                              setState(() => isExpanded = !isExpanded),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              isExpanded
                                  ? (translationState.isTranslated
                                  ? "عرض أقل"
                                  : "Show Less")
                                  : (translationState.isTranslated
                                  ? "اقرأ المزيد..."
                                  : "Read More..."),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        _buildTranslationButton(translationState),
                      ],
                    ),

                    const Divider(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LikesAndViewsRow(news: widget.news, like: null),
                        ActionsRow(news: widget.news),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationButton(TranslationState translationState) {
    return InkWell(
      onTap: translationState.isTranslating
          ? null
          : () {
        ref
            .read(translationViewModelProvider(widget.news.newsId).notifier)
            .toggleTranslation(
          title: widget.news.title,
          description: widget.news.des,
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