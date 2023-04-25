import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkStatus {
  Future<bool> get isConnected;
}

class NetworkStatusImpl implements NetworkStatus {
  late Connectivity connectivity;

  NetworkStatusImpl([Connectivity? connectivity]) {
    this.connectivity = connectivity ?? Connectivity();
  }

  @override
  Future<bool> get isConnected async {
    var connectivityResult = await connectivity.checkConnectivity();
    return Future.value(connectivityResult != ConnectivityResult.none);
  }
}
