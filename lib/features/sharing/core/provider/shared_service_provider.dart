import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/share_service.dart';
import '../service/share_service_impl.dart';

final shareServiceProvider = Provider<ShareService>((ref) {
  return ShareServiceImpl();
});