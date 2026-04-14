import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/vm/news_viewmodel_provider.dart';

class NewsCategoryList extends ConsumerWidget {
  final Function(String?) onCategorySelected;
  final String? selectedCategory;

  const NewsCategoryList({
    required this.onCategorySelected,
    this.selectedCategory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsVM = ref.read(newsViewModelProvider.notifier);

    return FutureBuilder<List<String>>(
      future: newsVM.fetchCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 50,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final categoryItems = newsVM.getCategoryItems(snapshot.data!);

        return SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            itemCount: categoryItems.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final category = categoryItems[i];
              final isSelected = category.isSelected(selectedCategory);

              return GestureDetector(
                onTap: () => onCategorySelected(category.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                      colors: [
                        Color(0xFF1E88E5),
                        Color(0xFF8E24AA),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                        : null,
                    color: isSelected
                        ? null
                        : const Color(0xFFB0B0B0).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: const Color(0xFF8E24AA).withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}