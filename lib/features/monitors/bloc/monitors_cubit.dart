import 'package:flutter/material.dart';
import 'package:up_api/features/monitors/bloc/monitors_state.dart';

import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/service/service_locator.dart';

class MonitorsCubit extends BaseCubit<MonitorsState> {
  MonitorsCubit(super.initialState, this.projectId);
  final ValueNotifier<int> resetTextHandler = ValueNotifier(0);
  final String projectId;

  Future<void> getMonitors({int top = 3, String? query}) async {
    emit(state.copyWith(isLoading: true));
    final response = await upapiMonitorsRepository.getMonitorsResponse(
      skip: state.skip,
      top: top,
      query: query ?? state.savedQuery,
      projectId: projectId,
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
        countMonitors: response?.count,
        skip: skip,
        monitors: [...?state.monitors, ...?response?.monitorsBody],
      ),
    );
  }

  void reset() {
    emit(MonitorsState());
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
