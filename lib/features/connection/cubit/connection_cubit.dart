import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:up_api/features/connection/cubit/connection_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';

class ConnectionCubit extends BaseCubit<ConnectionInternalState> {
  ConnectionCubit(super.initialState) {
    init();
  }

  void init() {
    Connectivity().onConnectivityChanged.listen(_checkConnection);
  }

  Future<void> refreshConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _checkConnection(connectivityResult);
  }

  void _checkConnection(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
      emit(state.copyWith(isConnected: true));
    } else {
      emit(state.copyWith(isConnected: true));
      emit(state.copyWith(isConnected: false));
    }
  }
}
