import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/provider/notification_dio_provider.dart';
import '../../datasources/remote/notification_remote_datasource.dart';
import '../../datasources/remote/notification_remote_datasource_impl.dart';

final notificationRemoteDataSourceProvider =
Provider<NotificationRemoteDataSource>((ref) {
  return NotificationRemoteDataSourceImpl(ref.watch(notificationDioProvider)
  ,dotenv.env['RENDER_API_URL'] ?? ''
  );
});