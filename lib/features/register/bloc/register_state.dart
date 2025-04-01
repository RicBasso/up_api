import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class RegisterState extends BaseState {
  RegisterState({
    this.isLoading = false,
    this.error = 0,
    this.emailError = 0,
    this.passError = 0,
    this.nameError = 0,
    this.surnameError = 0,
    this.businessError = 0,
  });

  RegisterState copyWith({
    bool? isLoading,
    int? error,
    int? emailError,
    int? passError,
    int? nameError,
    int? surnameError,
    int? businessError,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      emailError: emailError ?? this.emailError,
      passError: passError ?? this.passError,
      nameError: nameError ?? this.passError,
      surnameError: surnameError ?? this.passError,
      businessError: businessError ?? this.passError,
    );
  }

  final bool isLoading;
  final int error;
  final int emailError;
  final int passError;
  final int nameError;
  final int surnameError;
  final int businessError;

  @override
  List<Object?> get props => [isLoading, error, emailError, passError, nameError, surnameError, businessError];
}
