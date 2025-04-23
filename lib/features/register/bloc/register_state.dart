import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class RegisterState extends BaseState {
  RegisterState({
    this.isLoading = false,
    this.error,
    this.emailError = 0,
    this.passError = 0,
    this.nameError = 0,
    this.surnameError = 0,
    this.businessError = 0,
  });

  RegisterState copyWith({
    bool nullError = false,
    bool? isLoading,
    String? error,
    int? emailError,
    int? passError,
    int? nameError,
    int? surnameError,
    int? businessError,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: nullError ? null : error ?? this.error,
      emailError: emailError ?? this.emailError,
      passError: passError ?? this.passError,
      nameError: nameError ?? this.nameError,
      surnameError: surnameError ?? this.surnameError,
      businessError: businessError ?? this.businessError,
    );
  }

  final bool isLoading;
  final String? error;
  final int emailError;
  final int passError;
  final int nameError;
  final int surnameError;
  final int businessError;

  @override
  List<Object?> get props => [isLoading, error, emailError, passError, nameError, surnameError, businessError];
}
