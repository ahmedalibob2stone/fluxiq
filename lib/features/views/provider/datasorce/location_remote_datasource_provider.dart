import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/remote/location_remote_datasource.dart';
import '../../datasource/remote/location_remote_datasource_impl.dart';


import 'package:http/http.dart' as http;

final locationRemoteDatasourceProvider = Provider<LocationRemoteDatasource>((ref) {
  final url = dotenv.env['API_LOCATION'] ?? 'https://default-url.com';
  return LocationRemoteDatasourceImpl(
    apiUrl: url,
    client: http.Client(),
  );
});