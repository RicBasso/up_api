import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class WelcomeState extends BaseState {
  WelcomeState({
    this.heightPercentage = 0.35,

  });

  WelcomeState copyWith({
    double? heightPercentage,
  }) {
    return WelcomeState(
      heightPercentage: heightPercentage ?? this.heightPercentage,
    );
  }

  final double heightPercentage;

  @override
  List<Object?> get props => [heightPercentage,];
}
