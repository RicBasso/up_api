import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:up_api/features/home/bloc/home_cubit.dart';
import 'package:up_api/features/home/bloc/home_state.dart';
import 'package:up_api/features/menu/presentation/screen/menu.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/widgets/app_bar_widget.dart';
import 'package:up_api/widgets/card_widget.dart';
import 'package:up_api/widgets/load_more_button_widget.dart';
import 'package:up_api/widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(HomeState())..getProjects(top: 5),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: const AppBarWidget(),
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
                      AppLocalizations.of(context)?.home_page_title ?? 'home_page_title',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    UpApiSpacing.extraLarge,
                    SearchBarWidget(
                      title: AppLocalizations.of(context)?.search_project_title ?? 'search_project_title',
                      resetHandler: context.read<HomeCubit>().resetTextHandler,
                      onSearch: (query) async {
                        context.read<HomeCubit>().reset();
                        await context.read<HomeCubit>().getProjects(query: query);
                      },
                    ),
                    UpApiSpacing.large,
                    _buildListCardContent(context),
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

  Widget _buildListCardContent(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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

        final projects =
            (state.projects ?? []).map((project) {
              return CardWidget(
                title: project?.name,
                description:
                    (project?.monitor != null)
                        ? _calculateTime(project?.monitor?.lastCheckDate, context)
                        : AppLocalizations.of(context)?.empty_monitor ?? 'empty_monitor',
                result: project?.monitor?.lastCheckStatus,
                subTitle:
                    project?.monitor != null
                        ? (AppLocalizations.of(context)?.last_check_label ?? 'last_check_label')
                        : '',
                onTap:
                    () => upapiGoRouter.push(
                      '/home/monitors',
                      extra: {'projectId': project?.id, 'projectName': project?.name},
                    ),
              );
            }).toList();

        if (state.isLoading == false && projects.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)?.no_result_found ?? 'no_result_found'));
        } else {
          return Column(children: [...projects, ...loading]);
        }
      },
    );
  }

  Widget _buildLoadMore() {
    return Center(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return LoadMoreButtonWidget(
            buttonText: AppLocalizations.of(context)?.load_more_button ?? 'load_more_button',
            finishedText: AppLocalizations.of(context)?.load_more_button_finished ?? 'load_more_button_finished',
            current: state.skip,
            total: state.countProjects ?? 0,
            onPressed: () => context.read<HomeCubit>().getProjects(top: 5),
          );
        },
      ),
    );
  }

  Future<void> _refreshHandler(BuildContext context) async {
    context.read<HomeCubit>().reset();
    context.read<HomeCubit>().cleanSearchText();
    await context.read<HomeCubit>().getProjects(top: 5);
  }
}

String _calculateTime(DateTime? date, BuildContext context) {
  if (date == null) {
    return 'Error';
  }
  final now = DateTime.now().toUtc();
  final difference = now.difference(date.toUtc());

  final days = difference.inDays;
  final hours = difference.inHours % 24;
  final minutes = difference.inMinutes % 60;

  final parts = <String>[];

  if (days > 0) {
    parts.add(AppLocalizations.of(context)?.day_label(days) ?? 'hour_label');
  }

  if (hours > 0) {
    parts.add(AppLocalizations.of(context)?.hour_label(hours) ?? 'hour_label');
  }

  if (minutes > 0 /*&& days == 0*/ ) {
    parts.add(AppLocalizations.of(context)?.minute_label(minutes) ?? 'minute_label');
  }

  if (parts.isEmpty) {
    return AppLocalizations.of(context)?.less_one_minute ?? 'less_one_minute';
  }

  return '${parts.join(' ')} ${AppLocalizations.of(context)?.ago_label ?? 'ago_label'}';
}
