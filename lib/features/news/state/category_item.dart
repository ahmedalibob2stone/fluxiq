class CategoryItem {
  final String displayName;
  final String? value;

  const CategoryItem({
    required this.displayName,
    required this.value,
  });

  bool isSelected(String? selectedCategory) {
    return value == selectedCategory;
  }
}