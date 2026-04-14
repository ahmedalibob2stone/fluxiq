import 'dart:convert';
import 'package:http/http.dart' as http;
import 'location_remote_datasource.dart';


class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  final String apiUrl;
  final http.Client client;
  LocationRemoteDatasourceImpl({
    required this.apiUrl,
    required this.client,
  });

  @override
  Future<Map<String, dynamic>?> getLocationInfo() async {
    try {
      final response = await client
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}