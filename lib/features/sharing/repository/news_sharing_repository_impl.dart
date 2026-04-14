import 'package:uuid/uuid.dart';
import '../../../core/error/app_exception.dart';
import '../../news/model/news_model.dart';
import '../core/service/share_service.dart';
import '../core/utils/helpers/generate_web_link.dart';
import '../datasource/local/share_local_datasource.dart';
import '../datasource/remote/share_remote_datasource.dart';
import '../model/pending_share_model.dart';

import 'new_sharing_repository.dart';

class ShareRepositoryImpl implements ShareRepository {
  final ShareRemoteDatasource _remote;
  final ShareLocalDatasource _local;
  final ShareService _shareService;

  ShareRepositoryImpl(this._remote, this._local, this._shareService);

  @override
  Future<void> shareExternally({
    required NewsModel news,
    required String platform,
  }) async {
    final String link;

    if (!news.isUserPost &&
        news.sourceUrl != null &&
        news.sourceUrl!.isNotEmpty) {
      link = news.sourceUrl!;
    } else {
      link = generateWebLink(news.newsId);
    }

    final text = "${news.title}\n\n${news.des}\n\n$link";

    switch (platform) {
      case "CopyLink":
        await _shareService.copyLink(link);
        break;
      case "Telegram":
        await _shareService.shareToTelegram(link, news.title);
        break;
      case "Facebook":
        await _shareService.shareToFacebook(link);
        break;
      case "Other":
        await _shareService.shareText(text);
        break;
      default:
        throw const UnknownException(
            'An unexpected error occurred. Please try again..');
    }
  }

  @override
  Future<void> cacheShareEvent({
    required String newsId,
    required String userId,
    required String platform,
  }) async {
    final pending = CacheShareModel(
      shareId: const Uuid().v4(),
      newsId: newsId,
      userId: userId,
      platform: platform,
      sharedAt: DateTime.now(),
    );

    await _local.addPendingShare(pending);
    await _local.incrementShareCount(newsId, userId);
  }

  @override
  int getLocalShareCount({
    required String newsId,
    required String userId,
  }) {
    return _local.getShareCount(newsId, userId);
  }

  @override
  Future<void> syncPendingShares() async {
    final pendingShares = _local.getPendingShares();
    if (pendingShares.isEmpty) return;

    for (final share in pendingShares) {
      try {
        await _remote.saveShareToFirestore(share);
        await _local.removePendingShare(share.shareId);
      } catch (_) {
        break;
      }
    }
  }
}