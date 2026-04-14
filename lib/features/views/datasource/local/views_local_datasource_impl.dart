  import 'package:shared_preferences/shared_preferences.dart';
  import '../../model/cached_view_model.dart';
  import 'views_local_datasource.dart';

  class ViewsLocalDatasourceImpl implements ViewsLocalDatasource {
    static const String _viewedKey  = 'viewed_news_ids';
    static const String _pendingKey = 'pending_views';

    final SharedPreferences _prefs;

    ViewsLocalDatasourceImpl(this._prefs);


    @override
    Future<bool> isNewsViewed(String newsId) async {
      final viewedList = _prefs.getStringList(_viewedKey) ?? [];
      return viewedList.contains(newsId);
    }

    @override
    Future<void> markNewsAsViewed(String newsId) async {
      final viewedList = _prefs.getStringList(_viewedKey) ?? [];
      if (!viewedList.contains(newsId)) {
        viewedList.add(newsId);
        await _prefs.setStringList(_viewedKey, viewedList);
      }
    }


    @override
    Future<void> savePendingView(CachedViewModel view) async {
      final rawList = _prefs.getStringList(_pendingKey) ?? [];

      final alreadyExists = rawList.any((encoded) {
        final existing = CachedViewModel.fromEncodedString(encoded);
        return existing.newsId == view.newsId &&
            existing.userId == view.userId;
      });

      if (!alreadyExists) {
        rawList.add(view.toEncodedString());
        await _prefs.setStringList(_pendingKey, rawList);
      }
    }

    @override
    Future<List<CachedViewModel>> getPendingViews() async {
      final rawList = _prefs.getStringList(_pendingKey) ?? [];
      return rawList
          .map((e) => CachedViewModel.fromEncodedString(e))
          .toList();
    }

    @override
    Future<void> removePendingView({
      required String newsId,
      required String userId,
    }) async {
      final rawList = _prefs.getStringList(_pendingKey) ?? [];
      rawList.removeWhere((encoded) {
        final view = CachedViewModel.fromEncodedString(encoded);
        return view.newsId == newsId && view.userId == userId;
      });
      await _prefs.setStringList(_pendingKey, rawList);
    }
  }