  import 'package:connectivity_plus/connectivity_plus.dart';
import '../datasource/local/views_local_datasource.dart';
import '../datasource/remote/location_remote_datasource.dart';
import '../datasource/remote/views_remote_datasource.dart';
import '../model/cached_view_model.dart';
import '../model/news_view_model.dart';
import 'new_views_repository.dart';

class NewsViewsRepositoryImpl implements NewsViewsRepository {
  final ViewsRemoteDatasource    _viewsRemote;
  final LocationRemoteDatasource _locationRemote;
  final ViewsLocalDatasource     _local;
  NewsViewsRepositoryImpl(
      this._viewsRemote,
      this._locationRemote,
      this._local,
      );
  Future<bool> _isOnline() async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
  Future<void> addView({required String newsId, required String userId}) async {
    final alreadyViewed = await _local.isNewsViewed('$userId:$newsId');
    if (alreadyViewed) return;

    // علّم محليًا (حتى لا تكرر)
    await _local.markNewsAsViewed('$userId:$newsId');

    Map<String, dynamic>? locationData;
    try { locationData = await _locationRemote.getLocationInfo(); } catch (_) {}

    // اكتب في Firestore دائمًا (Firestore يتكفل بالأوفلاين)
    await _viewsRemote.pushView(
      newsId: newsId,
      userId: userId,
      locationData: locationData,
    );
  }
  @override
  Future<void> syncPendingViews() async {
    final online = await _isOnline();
    if (!online) return;

    final pendingViews = await _local.getPendingViews();
    if (pendingViews.isEmpty) return;

    for (final cached in pendingViews) {
      try {
        await _sendViewRemotely(
          newsId: cached.newsId,
          userId: cached.userId,
        );
        await _local.removePendingView(
          newsId: cached.newsId,
          userId: cached.userId,
        );
      } catch (_) {
        continue;
      }
    }
  }


  Future<void> _sendViewRemotely({
    required String newsId,
    required String userId,
  }) async {
    Map<String, dynamic>? locationData;
    try {
      locationData = await _locationRemote.getLocationInfo();
    } catch (_) {
      locationData = null;
    }

    await _viewsRemote.pushView(
      newsId: newsId,
      userId: userId,
      locationData: locationData,
    );
  }


  @override
  Stream<int> newsViewsStream(String newsId) {
    return _viewsRemote.newsViewsStream(newsId);
  }

  @override
  Future<List<NewsViewModelModel>> fetchViews(String newsId) {
    return _viewsRemote.fetchViews(newsId);
  }
}