  enum PublishNewsStatus {
    initial,
    publishing,
    success,
    failure,
    deleting,     
    deleteSuccess, 
  }

  class PublishNewsState {
    final PublishNewsStatus status;
    final String? errorMessage;
    final String? successMessage;

    final String? deletedNewsId;
    const PublishNewsState({required this.status, this.errorMessage,this.deletedNewsId,this.successMessage});

    factory PublishNewsState.initial() =>
        const PublishNewsState(status: PublishNewsStatus.initial);

    factory PublishNewsState.publishing() =>
        const PublishNewsState(status: PublishNewsStatus.publishing);

    factory PublishNewsState.success() =>
        const PublishNewsState(status: PublishNewsStatus.success);

    factory PublishNewsState.failure(String message) =>
        PublishNewsState(status: PublishNewsStatus.failure, errorMessage: message);
  }
