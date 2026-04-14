import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../connectivity/connectivity_datasource.dart';
import '../connectivity/connectivity_datasource_impl.dart';


import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final connectivityDatasourceProvider = Provider<ConnectivityDatasource>((ref) {
  return ConnectivityDatasourceImpl(
    ref.read(connectivityProvider),
    ref.read(httpClientProvider),
  );
});