import 'package:up_api/features/webhooks/bloc/webhooks_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/service/service_locator.dart';

class WebhooksCubit extends BaseCubit<WebhooksState> {
  WebhooksCubit(super.initialState, this.monitorId);
  final String monitorId;
  DateTime searchedAt = DateTime.now();

  Future<void> getWebhooks({int top = 3}) async {
    emit(state.copyWith(isLoading: true));
    final response = await upapiWebhooksRepository.getWebhooksResponse(
      skip: state.skip,
      top: top,
      monitorId: monitorId,
      searchedAt: searchedAt,
    );

    int? skip;
    if ((response?.count ?? 0) < state.skip + top) {
      skip = response?.count;
    } else {
      skip = state.skip + top;
    }
    emit(
      state.copyWith(
        isLoading: false,
        countWebhooks: response?.count,
        skip: skip,
        webhooks: [...?state.webhooks, ...?response?.webhooksBody],
      ),
    );
  }

  void reset() {
    searchedAt = DateTime.now();
    emit(WebhooksState());
  }
}
