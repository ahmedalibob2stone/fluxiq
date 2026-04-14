import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/ui/widgets/notification_Bell.dart';
import 'package:fluxiq/features/news/ui/widgets/search_news_delegate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_route_names.dart.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../../auth/provider/auth_viewmodel_provider.dart';
import '../../auth/state/auth_state.dart';


import '../provider/vm/news_viewmodel_provider.dart';
import '../provider/vm/publish_news_viewmodel_provider.dart';
import '../state/news_state.dart';
import '../state/publish_state.dart';
import 'widgets/news_category_list.dart';
import 'widgets/breaking_news_slider.dart';
import 'widgets/news_card.dart';

class NewsHomeScreen extends ConsumerStatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends ConsumerState<NewsHomeScreen> {
  final ScrollController _scrollCtrl = ScrollController();
  String? _selectedCategory;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsViewModelProvider.notifier).fetchNews();
    });
    _scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 50) {
      ref
          .read(newsViewModelProvider.notifier)
          .loadMoreNews(category: _selectedCategory);
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, color: Colors.blue, size: 40),
                const SizedBox(height: 15),
                const Text(
                  "Do you want to log out?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => context.pop(),

                              child: const Text(
                          "No",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          context.pop();
                          ref.read(authViewModelProvider.notifier).signOut();
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<NewsState>(newsViewModelProvider, (previous, next) {
      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: "Retry",
              textColor: Colors.white,
              onPressed: () {
                ref.read(newsViewModelProvider.notifier).fetchNews(category: _selectedCategory);
              },
            ),
          ),
        );
      }
    });
    ref.listen(authViewModelProvider, (previous, next) {

      if (next.error != null && next.error!.isNotEmpty) {
        FluxIQSnackBar.showError(context, next.error!);
      }

      if (next.status == AuthStatus.unauthenticated &&
          previous?.status != AuthStatus.unauthenticated) {
        context.goNamed(AppRouteNames.login);
      }
    });


    ref.listen<PublishNewsState>(publishingNewsProvider, (previous, next) {
      if (next.status == PublishNewsStatus.deleteSuccess) {

        final idToDelete = next.deletedNewsId;

        if (idToDelete != null) {
          ref.read(newsViewModelProvider.notifier).removeNewsLocally(idToDelete);
          FluxIQSnackBar.showSuccess(context, next.successMessage!);


        }

        ref.read(publishingNewsProvider.notifier).reset();
      }

      if (next.status == PublishNewsStatus.failure) {
        FluxIQSnackBar.showError(context, next.errorMessage!);
      }
    });    final state = ref.watch(newsViewModelProvider);
    final size = MediaQuery.of(context).size;
    final newsVM = ref.read(newsViewModelProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1E88E5),
                          Color(0xFF8E24AA),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Text(
                      "Menu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  ListTile(
                    leading:
                    const Icon(Icons.bookmark, color: Colors.amber),
                    title: const Text("Favorites"),
                    onTap: () {
                      context.pop();
                      context.goNamed(AppRouteNames.favorites);
                    },
                  ),

                  ListTile(
                    leading:
                    const Icon(Icons.favorite, color: Colors.red),
                    title: const Text("Likes"),
                    onTap: () {
                      context.pop();
                      context.goNamed(AppRouteNames.liked);
                    },
                  ),

                  const Divider(),

                  ListTile(
                    leading:
                    const Icon(Icons.logout, color: Colors.blue),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      context.pop();
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1E88E5),
                    Color(0xFF8E24AA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: const Text(
              'FluxIQ',
              style: TextStyle(
                fontFamily: 'MyCustomFont',
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 26,
                letterSpacing: 1.2,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),

            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () => showSearch(
                  context: context,
                  delegate: SearchNewsDelegate(ref),
                ),
              ),
              const NotificationBell(),
            ],
          ),          body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () => ref
              .read(newsViewModelProvider.notifier)
              .refreshNews(category: _selectedCategory),
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
                      color: Colors.blue),
                )
                    : ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    final newsItem = state.news[index];


                    return Padding(
                      padding:
                      const EdgeInsets.only(bottom: 12),
                      child: NewsCard(
                        news: state.news[index],
                       isMyPost: newsVM.isOwnPost(newsItem), ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
          floatingActionButton: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E88E5),
                  Color(0xFF8E24AA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () => context.pushNamed(AppRouteNames.createPost),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),

        Consumer(
          builder: (context, ref, _) {
            final loading =
            ref.watch(authViewModelProvider.select((s) => s.loading));

            if (!loading) return const SizedBox();

            return Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
        ),
      ],
    );
  }
}