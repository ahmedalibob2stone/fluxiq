

class LikesState {
  final bool isLiked;
  final int likesCount;
  final bool isLoading;
  final String? error;

  const LikesState({
    required this.isLiked,
    required this.likesCount,
    required this.isLoading,
    this.error,
  });

  LikesState copyWith({
    bool? isLiked,
    int? likesCount,
    bool? isLoading,
    String? error,
  }) {
    return LikesState(
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory LikesState.initial() {
    return const LikesState(
      isLiked: false,
      likesCount: 0,
      isLoading: false,
    );
  }
}