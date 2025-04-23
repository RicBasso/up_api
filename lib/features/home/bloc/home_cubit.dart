import 'package:flutter/material.dart';
import 'package:up_api/features/home/bloc/home_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/service/service_locator.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(super.initialState);
  final ValueNotifier<int> resetTextHandler = ValueNotifier(0);

  Future<void> getProjects({int top = 3, String? query}) async {
    emit(state.copyWith(isLoading: true));
    final response = await upapiProjectsRepository.getProjectsResponse(
      skip: state.skip,
      top: top,
      query: query ?? state.savedQuery,
    );
    int? skip;
    if ((response?.count ?? 0) < state.skip + top) {
      skip = response?.count;
    } else {
      skip = state.skip + top;
    }
    emit(
      state.copyWith(
        savedQuery: query,
        isLoading: false,
        countProjects: response?.count,
        skip: skip,
        projects: [...?state.projects, ...?response?.projectsBody],
      ),
    );
  }

  void reset() {
    emit(HomeState());
  }

  void cleanSearchText() {
    resetTextHandler.value++;
  }

  @override
  Future<void> close() {
    resetTextHandler.dispose();
    return super.close();
  }
}
