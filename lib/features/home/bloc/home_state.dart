import 'package:up_api/features/home/data/model/project.dart';
import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class HomeState extends BaseState {
  HomeState({
    this.isLoading = false,
    this.projects,
    this.skip = 0,
    this.countProjects,
    this.savedQuery,
  });

  final bool isLoading;
  List<Project?>? projects;
  final int skip;
  final int? countProjects;
  final String? savedQuery;

  HomeState copyWith({
    bool? isLoading,
    List<Project?>? projects,
    int? skip,
    int? countProjects,
    String? savedQuery,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      projects: projects ?? this.projects,
      skip: skip ?? this.skip,
      countProjects: countProjects ?? this.countProjects,
      savedQuery: savedQuery ?? this.savedQuery,
    );
  }

  @override
  List<Object?> get props => [isLoading, projects,];
}
