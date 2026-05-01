import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/vm/news_viewmodel_provider.dart';


mixin NewsScrollMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final ScrollController scrollCtrl = ScrollController();

  String? get selectedCategory;

  @protected
  void initScrollListener() {
    scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollCtrl.position.pixels >=
        scrollCtrl.position.maxScrollExtent - 50) {
      ref
          .read(newsViewModelProvider.notifier)
          .loadMoreNews(category: selectedCategory);
    }
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    super.dispose();
  }
}