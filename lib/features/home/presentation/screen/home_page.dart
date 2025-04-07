import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                      AppLocalizations
                          .of(context)
                          ?.home_page_title ??
                          'home_page_title',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge,
                    ),
                    UpApiSpacing.extraLarge,
                    SearchBarWidget(
                      resetHandler: context.read<HomeCubit>().resetTextHandler,
                      onSearch: (query) async {
                        context.read<HomeCubit>().reset();
                        await context.read<HomeCubit>().getProjects(query: query);
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final loading = state.isLoading
            ? List.generate(
          3,
              (_) =>
          const Skeletonizer(
            child: CardWidget(
              title: '**********',
              description: '****',
              result: true,
            ),
          ),
        )
            : <Skeletonizer>[];

        final projects = (state.projects ?? []).map((project) {
          return CardWidget(
            title: project?.name,
            description: '3 min fa',
            result: project?.status,
            onTap: () => upapiGoRouter.push('/home/${project?.id}/monitors'),
          );
        }).toList();

        if(state.isLoading == false && projects.isEmpty){
          return Center(child: Text(AppLocalizations
              .of(context)
              ?.no_result_fount ??
              'no_result_fount',),
          );
        }else{
          return Column(
            children: [...projects, ...loading],
          );
        }


      },
    );
  }

  Widget _buildLoadMore() {
    return Center(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return LoadMoreButtonWidget(
            buttonText: AppLocalizations
                .of(context)
                ?.load_more_button ?? 'load_more_button',
            finishedText: AppLocalizations
                .of(context)
                ?.load_more_button_finished ?? 'load_more_button_finished',
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
