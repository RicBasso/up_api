import 'package:up_api/features/home/data/model/project.dart';
import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class HomeState extends BaseState{
  HomeState({
    this.isLoading = false,
    this.projects,
  });

  final bool isLoading;
  List<Project?>? projects;

  HomeState copyWith({
    bool? isLoading,
    List<Project?>? projects,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [isLoading, projects];

}
