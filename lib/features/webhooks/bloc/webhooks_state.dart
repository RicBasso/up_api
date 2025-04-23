import 'package:up_api/features/webhooks/data/model/webhook.dart';
import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

class WebhooksState extends BaseState {
  WebhooksState({this.isLoading = false, this.webhooks, this.skip = 0, this.countWebhooks});

  final bool isLoading;
  List<Webhook?>? webhooks;
  final int skip;
  final int? countWebhooks;

  WebhooksState copyWith({bool? isLoading, List<Webhook?>? webhooks, int? skip, int? countWebhooks}) {
    return WebhooksState(
      isLoading: isLoading ?? this.isLoading,
      webhooks: webhooks ?? this.webhooks,
      skip: skip ?? this.skip,
      countWebhooks: countWebhooks ?? this.countWebhooks,
    );
  }

  @override
  List<Object?> get props => [isLoading, webhooks];
}
