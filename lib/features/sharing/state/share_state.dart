
enum ShareStatus {
  idle,
  loading,
  success,
  failure, initial,
}

class ShareState {
  final ShareStatus status;
  final String? errorMessage;
  final String? lastPlatform;

  const ShareState({
    this.status = ShareStatus.initial,
    this.errorMessage,
    this.lastPlatform,
  });

  ShareState copyWith({
    ShareStatus? status,
    String? errorMessage,
    String? lastPlatform,
  }) {
    return ShareState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      lastPlatform: lastPlatform ?? this.lastPlatform,
    );
  }
}
