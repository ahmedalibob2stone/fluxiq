  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:uuid/uuid.dart';
  import '../../../../core/error/app_exception.dart';
  import '../../../../core/error/firestore_error_handler.dart';
  import '../../model/news_model.dart';
  import 'news_firebase_datasource.dart';

  class NewsFirebaseDatasourceImpl implements NewsFirebaseDatasource {
    final FirebaseFirestore _db;

    NewsFirebaseDatasourceImpl({required FirebaseFirestore db}) : _db = db;

    @override
    Future<List<NewsModel>> fetchApiNews({
      String? category,
      int limit = 20,
      DateTime? startAfter,
    }) async {
      try {
        Query ref = _db
            .collection('news')
            .where('source', isEqualTo: 'api')
            .orderBy('createdAt', descending: true);

        if (category != null && category.isNotEmpty) {
          ref = ref.where('category', isEqualTo: category);
        }

        if (startAfter != null) {
          ref = ref.startAfter([Timestamp.fromDate(startAfter)]);
        }

        final snapshot = await ref.limit(limit).get();

        return snapshot.docs
            .map((doc) =>
            NewsModel.fromJson(doc.data()! as Map<String, dynamic>))
            .toList();
      } catch (e) {
        final error = ErrorHandler.handle(e);
        if (error is NetworkException) throw error;
        throw ErrorHandler.handle(e, 'Error fetching API news');
      }
    }

    @override
    Future<List<NewsModel>> fetchUserNews({
      String? category,
      DateTime? startAfter,
    }) async {
      try {
        Query ref = _db
            .collection('news')
            .where('source', isEqualTo: 'user')
            .orderBy('createdAt', descending: true);

        if (category != null && category.isNotEmpty) {
          ref = ref.where('category', isEqualTo: category);
        }

        if (startAfter != null) {
          ref = ref.startAfter([Timestamp.fromDate(startAfter)]);
        }

        final snapshot = await ref.get();

        return snapshot.docs
            .map((doc) =>
            NewsModel.fromJson(doc.data()! as Map<String, dynamic>))
            .toList();
      } catch (e) {
        throw ErrorHandler.handleFirestore(e, 'Error fetching user news');
      }
    }

    @override
    Future<List<NewsModel>> fetchMyPosts({
      required String userId,
      DateTime? startAfter,
    }) async {
      try {
        Query ref = _db
            .collection('news')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt', descending: true);

        if (startAfter != null) {
          ref = ref.startAfter([Timestamp.fromDate(startAfter)]);
        }

        final snapshot = await ref.get();

        return snapshot.docs
            .map((doc) =>
            NewsModel.fromJson(doc.data()! as Map<String, dynamic>))
            .toList();
      } catch (e) {
        throw ErrorHandler.handleFirestore(e);
      }
    }

    Future<void> saveApiNews({
      required List<NewsModel> newsList,
      required String currentUserRole,
    }) async {
      try {
        // 1. اجلب الأخبار الموجودة مع حالة breakingNotificationSent
        final existingBreaking = await _db
            .collection('news')
            .where('isBreaking', isEqualTo: true)
            .get();

        // استخرج IDs الأخبار التي سبق إرسال إشعارها
        final Set<String> alreadySentIds = existingBreaking.docs
            .where((doc) => doc.data()['breakingNotificationSent'] == true)
            .map((doc) => doc.id)
            .toSet();

        int currentBreakingCount = existingBreaking.docs.length;
        const int maxBreaking = 6;

        final batch = _db.batch();
        final sortedNews = [...newsList]
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        for (final news in sortedNews) {
          final doc = _db.collection('news').doc(news.newsId);
          final bool isBreaking = currentBreakingCount < maxBreaking;
          if (isBreaking) currentBreakingCount++;

          final secureNews = news.copyWith(
            authorRole: 'admin',
            isUserPost: false,
            source: 'api',
            isBreaking: isBreaking,
          );

          final bool alreadySent = alreadySentIds.contains(news.newsId);

          batch.set(
            doc,
            {
              ...secureNews.toJson(),
              if (isBreaking && !alreadySent) 'breakingNotificationSent': false,
            },
            SetOptions(merge: true),
          );
        }

        await batch.commit();
      } catch (e) {
        throw ErrorHandler.handle(e, 'Failed to save API data');
      }
    }
    @override
    Future<void> publishNews({
      required String userId,
      required String title,
      required String des,
      required String imageUrl,
      required String category,
      bool isBreaking = false,
    }) async {
      try {
        final newsId = const Uuid().v4();
        final doc = _db.collection('news').doc(newsId);

        final news = NewsModel(
          newsId: newsId,
          title: title,
          des: des,
          imageUrl: imageUrl,
          category: category,
          createdAt: DateTime.now(),
          isBreaking: isBreaking,
          userId: userId,
          isUserPost: true,
          sourceUrl: null,
          authorRole: 'user',
          source: 'user',
        );

        await doc.set(
          {...news.toJson(), 'userId': userId, 'category': category,   if (isBreaking) 'breakingNotificationSent': false,},
          SetOptions(merge: true),
        );

      } catch (e) {
        throw ErrorHandler.handle(e);
      }
    }

    @override
    Future<List<NewsModel>> fetchBreakingNews({int limit = 6}) async {
      try {
        final snap = await _db
            .collection('news')
            .where('isBreaking', isEqualTo: true)
            .orderBy('createdAt', descending: true)
            .limit(limit)
            .get();

        return snap.docs
            .map((doc) => NewsModel.fromJson(doc.data()!))
            .toList();
      } catch (e) {
        throw ErrorHandler.handleFirestore(e);
      }
    }

    @override
    Future<List<NewsModel>> searchNews({
      String? category,
      required String query,
    }) async {
      try {
        Query ref = _db.collection('news');

        if (category != null && category.isNotEmpty) {
          ref = ref.where('category', isEqualTo: category);
        }

        final snap = await ref.get();

        return snap.docs
            .map((doc) =>
            NewsModel.fromJson(doc.data()! as Map<String, dynamic>))
            .where((news) =>
            news.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } catch (e) {
        throw ErrorHandler.handleFirestore(e);
      }
    }

    @override
    Future<void> deleteNews({
      required String newsId,
      required String userId,
    }) async {
      try {
        await _db.collection('news').doc(newsId).delete();
      } catch (e) {
        throw ErrorHandler.handleFirestore(e);
      }
    }

    @override
    Future<List<NewsModel>> getNewsByIds(List<String> ids) async {
      if (ids.isEmpty) return [];

      try {
        final List<NewsModel> result = [];
        const chunkSize = 10;

        for (var i = 0; i < ids.length; i += chunkSize) {
          final chunk = ids.sublist(
            i,
            i + chunkSize > ids.length ? ids.length : i + chunkSize,
          );

          final snapshot = await _db
              .collection('news')
              .where(FieldPath.documentId, whereIn: chunk)
              .get();

          result.addAll(
            snapshot.docs.map((doc) => NewsModel.fromJson(doc.data())),
          );
        }

        return result;
      } catch (e) {
        throw ErrorHandler.handleFirestore(e);
      }
    }
  }