import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/screens/home/widgets/auth_loading_overlay.dart';
import 'package:fluxiq/features/news/screens/home/widgets/breaking_news_slider.dart';
import 'package:fluxiq/features/news/screens/home/widgets/news_state_listener.dart';
import 'package:fluxiq/features/news/screens/home/widgets/news_card.dart';
import 'package:fluxiq/features/news/screens/home/widgets/news_category_list.dart';
import 'package:fluxiq/features/news/screens/home/widgets/news_home_app_bar.dart';
import 'package:fluxiq/features/news/screens/home/widgets/news_home_drawer.dart';

import '../../../../core/listeners/auth_listeners.dart';

import '../../provider/vm/news_viewmodel_provider.dart';

import '../../../../core/listeners/publish_state_listener.dart';

import 'mixins/news_scroll_mixin.dart';

import 'widgets/news_home_fab.dart';
class NewsHomeScreen extends ConsumerStatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends ConsumerState<NewsHomeScreen>
    with NewsScrollMixin {
  String? _selectedCategory;

  @override
  String? get selectedCategory => _selectedCategory;

  @override
  void initState() {
    super.initState();
    initScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsViewModelProvider.notifier).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsViewModelProvider);
    final newsVM = ref.read(newsViewModelProvider.notifier);
    final size = MediaQuery.of(context).size;

    return AuthListeners(
      child: NewsStateListener(
        selectedCategory: _selectedCategory,
        child: PublishStateListener(
          child: Stack(
            children: [
              Scaffold(
                drawer: const NewsHomeDrawer(),
                backgroundColor: Colors.white,
                appBar: const NewsHomeAppBar(),
                body: RefreshIndicator(
                  color: Colors.blue,
                  onRefresh: () =>
                      newsVM.refreshNews(category: _selectedCategory),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: NewsCategoryList(
                          selectedCategory: _selectedCategory,
                          onCategorySelected: (cat) {
                            setState(() => _selectedCategory = cat);
                            ref
                                .read(newsViewModelProvider.notifier)
                                .fetchNews(category: cat, refresh: true);
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.25,
                        child: const BreakingNewsSlider(),
                      ),
                      Expanded(
                        child: state.loading && state.news.isEmpty
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                            : ListView.builder(
                          controller: scrollCtrl,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          itemCount: state.news.length,
                          itemBuilder: (context, index) {
                            final newsItem = state.news[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: NewsCard(
                                news: newsItem,
                                isMyPost: newsVM.isOwnPost(newsItem),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: const NewsHomeFab(),
              ),
              const AuthLoadingOverlay(),
            ],
          ),
        ),
      ),
    );
  }
}
