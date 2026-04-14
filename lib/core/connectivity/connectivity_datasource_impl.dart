import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'connectivity_datasource.dart';
class ConnectivityDatasourceImpl implements ConnectivityDatasource {
  final Connectivity _connectivity;
  final http.Client _client;

  ConnectivityDatasourceImpl(this._connectivity, this._client);

  @override
  Future<bool> hasActualInternet() async {
    final results = await _connectivity.checkConnectivity();
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    if (!hasNetwork) return false;

    try {
      final response = await _client
          .get(Uri.parse('https://google.com'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((results) {
      return results.any((r) => r != ConnectivityResult.none);
    });
  }
}