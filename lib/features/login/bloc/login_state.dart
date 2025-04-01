import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class LoginState extends BaseState {
  LoginState({
    this.isLoading = false,
    this.error,
    this.emailError,
    this.passError,
  });

  LoginState copyWith({
    bool nullPass = false,
    bool nullEmail = false,
    bool nullError = false,
    bool? isLoading,
    String? error,
    String? emailError,
    String? passError,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: nullError ? null : error ?? this.error,
      emailError: nullEmail ? null : emailError ?? this.emailError,
      passError: nullPass ? null : passError ?? this.passError,
    );
  }

  final bool isLoading;
  final String? error;
  final String? emailError;
  final String? passError;

  @override
  List<Object?> get props => [isLoading, error, emailError, passError];
}
