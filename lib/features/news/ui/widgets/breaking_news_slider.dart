import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../core/widgets/breaking_news_card_widget.dart';
import '../../provider/vm/breaking_news_viewmodel_provider.dart';
import '../../state/news_state.dart';
class BreakingNewsSlider extends ConsumerWidget {
  const BreakingNewsSlider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(breakingNewsProvider);

    if (state.news.isEmpty && !state.loading) {
      return const SizedBox.shrink();
    }
    final sliderHeight = MediaQuery.of(context).size.height * 0.22;

    final itemWidth = MediaQuery.of(context).size.width * 0.75;

    return Container(
      height: sliderHeight,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: _buildContent(state, itemWidth),
    );

  }

  Widget _buildContent(NewsState state, double itemWidth) {
    if (state.loading && state.news.isEmpty) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (state.news.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.news.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final news = state.news[index];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500 + (index * 100)),
          curve: Curves.easeOutQuart,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(30 * (1 - value), 0),
                child: child,
              ),
            );
          },
          child: BreakingNewsCard(news: news, width: itemWidth),
        );
      },
    );
  }
}



