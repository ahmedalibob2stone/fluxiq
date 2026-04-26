abstract class ILocalNotificationService {
  Future<void> initialize();
  Future<void> show({
    required int id,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required String type,
    String? imageUrl,
    String? payload,
  });
}