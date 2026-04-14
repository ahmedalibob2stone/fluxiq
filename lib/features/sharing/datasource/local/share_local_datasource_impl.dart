import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/pending_share_model.dart';
import 'share_local_datasource.dart';

class ShareLocalDatasourceImpl implements ShareLocalDatasource {
  static const String _pendingKey = 'pending_shares';
  final SharedPreferences _prefs;

  ShareLocalDatasourceImpl(this._prefs);

  @override
  Future<void> addPendingShare(CacheShareModel share) async {
    final list = _getPendingList();
    list.add(share.toJson());
    await _prefs.setString(_pendingKey, jsonEncode(list));
  }

  @override
  List<CacheShareModel> getPendingShares() {
    final list = _getPendingList();
    return list.map((e) => CacheShareModel.fromJson(e)).toList();
  }

  @override
  Future<void> removePendingShare(String shareId) async {
    final list = _getPendingList();
    list.removeWhere((e) => e['shareId'] == shareId);
    await _prefs.setString(_pendingKey, jsonEncode(list));
  }

  @override
  int getShareCount(String newsId, String userId) {
    return _prefs.getInt(_countKey(newsId, userId)) ?? 0;
  }

  @override
  Future<void> incrementShareCount(String newsId, String userId) async {
    final current = getShareCount(newsId, userId);
    await _prefs.setInt(_countKey(newsId, userId), current + 1);
  }

  String _countKey(String newsId, String userId) =>
      'share_count_${newsId}_$userId';

  List<Map<String, dynamic>> _getPendingList() {
    final raw = _prefs.getString(_pendingKey);
    if (raw == null || raw.isEmpty) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(raw));
  }
}