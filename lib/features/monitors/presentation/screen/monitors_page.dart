import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:up_api/features/monitors/bloc/monitors_cubit.dart';
import 'package:up_api/features/monitors/bloc/monitors_state.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/widgets/card_widget.dart';
import 'package:up_api/widgets/internal_app_bar_widget.dart';
import 'package:up_api/widgets/load_more_button_widget.dart';
import 'package:up_api/widgets/search_bar_widget.dart';

class MonitorsPage extends StatelessWidget {
  const MonitorsPage({required this.projectId, required this.projectName, super.key});
  final String projectId;
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MonitorsCubit>(
      create: (context) => MonitorsCubit(MonitorsState(), projectId)..getMonitors(top: 5),
      child: MonitorsScreen(projectName: projectName),
    );
  }
}

class MonitorsScreen extends StatelessWidget {
  const MonitorsScreen({required this.projectName, super.key});
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InternalAppBarWidget(title: projectName),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refreshHandler(context),
          child: ListView(
            children: [
              Padding(
                padding: UpApiPadding.basicPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.monitors_page_title ?? 'monitors_page_title',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    UpApiSpacing.extraLarge,
                    SearchBarWidget(
                      title: AppLocalizations.of(context)?.search_monitor_title ?? 'search_monitors_title',
                      resetHandler: context.read<MonitorsCubit>().resetTextHandler,
                      onSearch: (query) async {
                        context.read<MonitorsCubit>().reset();
                        await context.read<MonitorsCubit>().getMonitors(query: query);
                      },
                    ),
                    UpApiSpacing.large,
                    _buildListCardContent(),
                    _buildLoadMore(),
                    UpApiSpacing.large,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCardContent() {
    return BlocBuilder<MonitorsCubit, MonitorsState>(
      builder: (context, state) {
        final loading =
            state.isLoading
                ? List.generate(
                  3,
                  (_) => const Skeletonizer(
                    child: CardWidget(
                      title: '**********',
                      description: '****',
                      //result: true,
                    ),
                  ),
                )
                : <Skeletonizer>[];

        final monitors =
            (state.monitors ?? []).map((monitor) {
              return CardWidget(
                title: monitor?.name,
                description: '${monitor?.type}://${monitor?.url}',
                result: monitor?.lastCheckStatus,
                onTap: () => upapiGoRouter.push('/home/monitors/${monitor?.id}', extra: {'monitorName': monitor?.name}),
              );
            }).toList();

        if (state.isLoading == false && monitors.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)?.no_result_found ?? 'no_result_found'));
        } else {
          return Column(children: [...monitors, ...loading]);
        }
      },
    );
  }

  Widget _buildLoadMore() {
    return Center(
      child: BlocBuilder<MonitorsCubit, MonitorsState>(
        builder: (context, state) {
          return LoadMoreButtonWidget(
            buttonText: AppLocalizations.of(context)?.load_more_button ?? 'load_more_button',
            finishedText: AppLocalizations.of(context)?.load_more_button_finished ?? 'load_more_button_finished',
            current: state.skip,
            total: state.countMonitors ?? 0,
            onPressed: () => context.read<MonitorsCubit>().getMonitors(top: 20),
          );
        },
      ),
    );
  }

  Future<void> _refreshHandler(BuildContext context) async {
    context.read<MonitorsCubit>().reset();
    context.read<MonitorsCubit>().cleanSearchText();
    await context.read<MonitorsCubit>().getMonitors(top: 5);
  }
}
