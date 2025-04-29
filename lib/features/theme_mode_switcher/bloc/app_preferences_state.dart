import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class AppPreferencesState extends BaseState {
  AppPreferencesState({this.onDark = false, this.location = 'en'});

  final bool onDark;
  final String location;

  AppPreferencesState copyWith({bool? onDark, String? location}) {
    return AppPreferencesState(
      onDark: onDark ?? this.onDark,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [onDark, location];

}
