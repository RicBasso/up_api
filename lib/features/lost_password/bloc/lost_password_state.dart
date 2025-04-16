import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class LostPasswordState extends BaseState {
  LostPasswordState({
    this.isLoading = false,
    this.completed = false,
    this.error = 0,
    this.emailError = 0,
  });

  LostPasswordState copyWith({
    bool? isLoading,
    int? error,
    int? emailError,
    bool? completed,
  }) {
    return LostPasswordState(
      isLoading: isLoading ?? this.isLoading,
      completed: completed ?? this.completed,
      error: error ?? this.error,
      emailError: emailError ?? this.emailError,
    );
  }

  final bool isLoading;
  final bool completed;
  final int error;
  final int emailError;


  @override
  List<Object?> get props => [
    isLoading,
    error,
    emailError,
    completed,
  ];
}
