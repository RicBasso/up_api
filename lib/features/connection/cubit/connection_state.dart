import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class ConnectionInternalState extends BaseState {
  ConnectionInternalState({
    this.isConnected = true,
  });


  final bool isConnected;

  ConnectionInternalState copyWith({
    bool? isConnected,
  }) {
    return ConnectionInternalState(
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [isConnected,];
}
