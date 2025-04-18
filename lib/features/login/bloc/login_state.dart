import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class LoginState extends BaseState {
  LoginState({
    this.isLoading = false,
    this.error,
    this.emailError = 0,
    this.passError = 0,
  });

  LoginState copyWith({
    bool nullError = false,
    bool? isLoading,
    String? error,
    int? emailError,
    int? passError,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: nullError ? null : error ?? this.error,
      emailError: emailError ?? this.emailError,
      passError: passError ?? this.passError,
    );
  }

  final bool isLoading;
  final String? error;
  final int emailError;
  final int passError;

  @override
  List<Object?> get props => [isLoading, error, emailError, passError];
}
