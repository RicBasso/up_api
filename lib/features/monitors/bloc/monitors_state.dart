import 'package:up_api/features/monitors/data/model/monitor.dart';
import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class MonitorsState extends BaseState {
  MonitorsState({this.isLoading = false, this.monitors, this.skip = 0, this.countMonitors, this.savedQuery});

  final bool isLoading;
  List<Monitor?>? monitors;
  final int skip;
  final int? countMonitors;
  final String? savedQuery;

  MonitorsState copyWith({
    bool? isLoading,
    List<Monitor?>? monitors,
    int? skip,
    int? countMonitors,
    String? savedQuery,
  }) {
    return MonitorsState(
      isLoading: isLoading ?? this.isLoading,
      monitors: monitors ?? this.monitors,
      skip: skip ?? this.skip,
      countMonitors: countMonitors ?? this.countMonitors,
      savedQuery: savedQuery ?? this.savedQuery,
    );
  }

  @override
  List<Object?> get props => [isLoading, monitors];
}
