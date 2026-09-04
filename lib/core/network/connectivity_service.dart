import 'package:connectivity_plus/connectivity_plus.dart';
abstract class ConnectivityService {
  Future<bool>checkConnection();
  Stream<bool>get connectionStream;
}
class ConnectivityServiceImpl implements ConnectivityService{
  final Connectivity connectivity;
  ConnectivityServiceImpl({
    required this.connectivity,
});
  @override
  Future<bool> checkConnection() async{
  final results=await connectivity.checkConnectivity();
  return _hasConnection(results);
}
@override
Stream<bool>get connectionStream{
  return connectivity.onConnectivityChanged.map(_hasConnection);
}
bool _hasConnection(List<ConnectivityResult>results){
  return !results.contains(ConnectivityResult.none);
}
}