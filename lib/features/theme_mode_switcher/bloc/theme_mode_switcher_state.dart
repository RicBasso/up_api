import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class ThemeModeSwitcherState extends BaseState {
  ThemeModeSwitcherState({this.onDark = false});

  final bool onDark;

  ThemeModeSwitcherState copyWith({bool? onDark}) {
    return ThemeModeSwitcherState(onDark: onDark ?? this.onDark);
  }

  @override
  List<Object?> get props => [onDark];
}
