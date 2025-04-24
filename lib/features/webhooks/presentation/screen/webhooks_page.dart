import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:up_api/features/webhooks/bloc/webhooks_cubit.dart';
import 'package:up_api/features/webhooks/bloc/webhooks_state.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/widgets/card_widget.dart';
import 'package:up_api/widgets/internal_app_bar_widget.dart';
import 'package:up_api/widgets/load_more_button_widget.dart';

class WebhooksPage extends StatelessWidget {
  const WebhooksPage({required this.monitorId, required this.monitorName, super.key});
  final String monitorId;
  final String monitorName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WebhooksCubit>(
      create: (context) => WebhooksCubit(WebhooksState(), monitorId)..getWebhooks(top: 5),
      child: WebhooksScreen(monitorName: monitorName),
    );
  }
}

class WebhooksScreen extends StatelessWidget {
  const WebhooksScreen({required this.monitorName, super.key});
  final String monitorName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InternalAppBarWidget(title: monitorName),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refreshHandler(context),
          child: ListView(
            children: [
              Padding(
                padding: UpApiPadding.basicPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildListCardContent(), _buildLoadMore(), UpApiSpacing.large],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCardContent() {
    return BlocBuilder<WebhooksCubit, WebhooksState>(
      builder: (context, state) {
        final loading =
            state.isLoading
                ? List.generate(
                  3,
                  (_) => const Skeletonizer(
                    child: CardWidget(
                      description: '****************',
                      //result: true,
                    ),
                  ),
                )
                : <Skeletonizer>[];

        final webhooks =
            (state.webhooks ?? []).map((webhook) {
              return CardWidget(
                description:
                    webhook?.executionDate != null
                        ? _formatApiDate(webhook?.executionDate, context)
                        : '${AppLocalizations.of(context)?.webhooks_requested_at ?? 'webhooks_requested_at'}\n${_formatApiDate(webhook?.requestedExecutionDate, context)}',
                result: webhook?.result,
              );
            }).toList();

        if (state.isLoading == false && webhooks.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)?.no_result_found ?? 'no_result_found'));
        } else {
          return Column(children: [...webhooks, ...loading]);
        }
      },
    );
  }

  Widget _buildLoadMore() {
    return Center(
      child: BlocBuilder<WebhooksCubit, WebhooksState>(
        builder: (context, state) {
          return LoadMoreButtonWidget(
            buttonText: AppLocalizations.of(context)?.load_more_button ?? 'load_more_button',
            finishedText: AppLocalizations.of(context)?.load_more_button_finished ?? 'load_more_button_finished',
            current: state.skip,
            total: state.countWebhooks ?? 0,
            onPressed: () => context.read<WebhooksCubit>().getWebhooks(top: 5),
          );
        },
      ),
    );
  }

  Future<void> _refreshHandler(BuildContext context) async {
    context.read<WebhooksCubit>().reset();
    await context.read<WebhooksCubit>().getWebhooks(top: 5);
  }

  String _formatApiDate(DateTime? date, BuildContext context) {
    if (date == null) {
      return AppLocalizations.of(context)?.unknown_date_label ?? 'unknown_date_label';
    }
    final locale = AppLocalizations.of(context)?.localeName; //oppure Localizations.localeOf(context).toLanguageTag()
    final formatter = DateFormat.yMd(locale);
    final time = DateFormat.Hm(locale);
    return '${formatter.format(date)} - ${time.format(date)}';
  }
}
