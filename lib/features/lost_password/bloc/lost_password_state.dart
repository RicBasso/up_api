import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class LostPasswordState extends BaseState {
  LostPasswordState({
    this.isLoading = false,
    this.completed = false,
    this.error,
    this.emailError = 0,
  });

  LostPasswordState copyWith({
    bool nullError = false,
    bool? isLoading,
    String? error,
    int? emailError,
    bool? completed,
  }) {
    return LostPasswordState(
      isLoading: isLoading ?? this.isLoading,
      completed: completed ?? this.completed,
      error: nullError ? null : error ?? this.error,
      emailError: emailError ?? this.emailError,
    );
  }

  final bool isLoading;
  final bool completed;
  final String? error;
  final int emailError;


  @override
  List<Object?> get props => [
    isLoading,
    error,
    emailError,
    completed,
  ];
}
