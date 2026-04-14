import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetConnection {
  final CheckInternet _checker;


  CheckInternetConnection({CheckInternet? checker})
      : _checker = checker ?? CheckInternet();

  Future<bool> checkInternet() async {
    return await _checker.isConnected();
  }
}

class CheckInternet {
  final http.Client client;

  CheckInternet({http.Client? client})
      : client = client ?? http.Client();

  Future<bool> isConnected() async {
    try {
      final response = await client
          .get(Uri.parse('https://example.com'))
          .timeout(const Duration(seconds: 2));

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

Future<bool> get hasConnection async {
  final result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}