import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class AddMonitorState extends BaseState {
  AddMonitorState({
    this.completed = false,
    this.isLoading = false,
    this.error,
    this.nameError = 0,
    this.urlError = 0,
    this.methodError = 0,
  });

  AddMonitorState copyWith({
    bool nullError = false,
    bool? completed,
    bool? isLoading,
    String? error,
    int? nameError,
    int? urlError,
    int? methodError,
  }) {
    return AddMonitorState(
      completed: completed ?? this.completed,
      isLoading: isLoading ?? this.isLoading,
      error: nullError ? null : error ?? this.error,
      urlError: urlError ?? this.urlError,
      nameError: nameError ?? this.nameError,
      methodError: methodError ?? this.methodError,
    );
  }

  final bool completed;
  final bool isLoading;
  final String? error;
  final int nameError;
  final int urlError;
  final int methodError;

  @override
  List<Object?> get props => [completed, isLoading, error, nameError, urlError, methodError,];
}
