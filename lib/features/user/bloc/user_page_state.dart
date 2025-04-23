import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class UserPageState extends BaseState {
  UserPageState({
    this.completed = false,
    this.isLoading = false,
    this.error,
    this.nameError = 0,
    this.surnameError = 0,
    this.emailError = 0,
    this.phoneError = 0,
  });

  UserPageState copyWith({
    bool nullError = false,
    bool? completed,
    bool? isLoading,
    String? error,
    int? nameError,
    int? surnameError,
    int? emailError,
    int? phoneError,
  }) {
    return UserPageState(
      completed: completed ?? this.completed,
      isLoading: isLoading ?? this.isLoading,
      error: nullError ? null : error ?? this.error,
      emailError: emailError ?? this.emailError,
      nameError: nameError ?? this.nameError,
      surnameError: surnameError ?? this.surnameError,
      phoneError: phoneError ?? this.phoneError,
    );
  }

  final bool completed;
  final bool isLoading;
  final String? error;
  final int nameError;
  final int surnameError;
  final int emailError;
  final int phoneError;

  @override
  List<Object?> get props => [completed, isLoading, error, nameError, surnameError, emailError, phoneError];
}
