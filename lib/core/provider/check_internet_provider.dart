import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/check_internet.dart';

final checkInternetProvider = Provider<CheckInternetConnection>((ref) {
  return CheckInternetConnection();
});