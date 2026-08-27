abstract class NetworkEvent {
  const NetworkEvent();
}
class CheckNetworkStatus extends NetworkEvent{
  const CheckNetworkStatus();
}
class NetworkStatusChanged extends NetworkEvent{
  final bool isConnected;
  const NetworkStatusChanged(this.isConnected);
}
