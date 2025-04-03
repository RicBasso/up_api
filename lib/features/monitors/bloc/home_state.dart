import 'package:up_api/features/home/data/model/project.dart';
import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class HomeState extends BaseState{
  HomeState({
    this.isLoading = false,
    this.monitors,
  });

  final bool isLoading;
  List<Project?>? monitors;

  @override
  List<Object?> get props => [isLoading, monitors];

}
