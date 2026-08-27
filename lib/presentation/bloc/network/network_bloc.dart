import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winnapp/presentation/bloc/network/network_event.dart';
import 'package:winnapp/presentation/bloc/network/network_state.dart';

import '../../../core/network/connectivity_service.dart';

class NetworkBloc extends Bloc<NetworkEvent,NetworkState>{
  final ConnectivityService connectivityService;

  StreamSubscription<bool>?_connectionSubsrciption;
  NetworkBloc({
    required this.connectivityService,
}):super(const NetworkInitial()){
    on<CheckNetworkStatus>(_onCheckNetworkStatus);
    on<NetworkStatusChanged>(_onNetworkStatusChanged);

    _connectionSubsrciption=connectivityService.connectionStream.listen(
        (isConnected){
          add(NetworkStatusChanged(isConnected));
        },
    );
  }
  Future<void>_onCheckNetworkStatus(
      CheckNetworkStatus event,
      Emitter<NetworkState>emit,
      )async{
    final isConnected=await connectivityService.checkConnection();
    if(isConnected){
      emit(const NetworkOnline());
    }else{
      emit(const NetworkOffline());
    }
  }
  void  _onNetworkStatusChanged(
      NetworkStatusChanged event,
      Emitter<NetworkState>emit,
      ){
    if(event.isConnected){
      emit(const NetworkOnline());
    }else{
      emit(const NetworkOffline());
    }
  }
  @override
  Future<void>close(){
    _connectionSubsrciption?.cancel();
    return super.close();
  }
}