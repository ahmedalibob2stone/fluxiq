import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/connectivity/connectivity_datasource.dart';
import '../../../core/error/firestore_error_handler.dart';

import '../core/utills/validators/validators.dart';
import '../repository/news_repository.dart';
import '../state/publish_state.dart';


class PublishingNewsViewModel extends StateNotifier<PublishNewsState> {
  final String? userId;
  final NewsRepository repository;
  final ConnectivityDatasource connectivityDatasource;

  PublishingNewsViewModel({
    required this.userId,
    required this.repository,
    required this.connectivityDatasource,
  }) : super(PublishNewsState.initial());



  Future<void> publish({
    required String title,
    required String description,
    required String imageUrl,
    required String category,
    bool isBreaking = false,
  }) async {
    if (userId == null || userId!.isEmpty) {
      state = PublishNewsState.failure("User not authenticated");
      return;
    }
    final hasInternet = await connectivityDatasource.hasActualInternet();
    if (!hasInternet) {
      state = PublishNewsState.failure("No internet connection.");
      return;
    }

    final validationError = Validators.validatePublishFields(
      title: title,
      description: description,
      imageUrl: imageUrl,
      category: category,
    );

    if (validationError != null) {
      state = PublishNewsState.failure(validationError);
      return;
    }

    state = PublishNewsState.publishing();

    try {
      await repository.publishNews(
        userId: userId!,
        title: title.trim(),
        des: description.trim(),
        imageUrl: imageUrl.trim(),
        category: category,
        isBreaking: isBreaking,
      );

      state = PublishNewsState(
          status: PublishNewsStatus.success,
          successMessage: "News published successfully!"
      );    } catch (e) {
      state = PublishNewsState(
          status: PublishNewsStatus.failure,
          errorMessage: "Failed to publish the New: ${ErrorHandler.handle(e)}"
      );    }
  }

  Future<void> deleteMyPost(String newsId) async {
    if (userId == null || userId!.isEmpty) {
      if (mounted) state = PublishNewsState.failure("User not authenticated");
      return;
    }

    if (!await connectivityDatasource.hasActualInternet()) {
      if (mounted) state = PublishNewsState.failure("No internet connection.");
      return;
    }

 state = PublishNewsState(
        status: PublishNewsStatus.deleting,
        deletedNewsId: newsId
    );
    try {
      await repository.deleteNews(newsId: newsId, userId: userId!);

      if (mounted) {
        state = PublishNewsState(
            status: PublishNewsStatus.deleteSuccess,
            deletedNewsId: newsId ,
            successMessage: "News deleted successfully"


    );
      }
    } catch (e) {
      if (mounted) {
        state = PublishNewsState(
            status: PublishNewsStatus.failure,
            errorMessage: "Failed to delete the New: ${ErrorHandler.handle(e)}"
        );
      }
    }
  }
  void reset() {
    state = PublishNewsState.initial();
  }
}