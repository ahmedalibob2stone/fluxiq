abstract class ConnectivityDatasource {
  Future<bool> hasActualInternet();
  Stream<bool> get connectivityStream;
}