import 'package:up_api/features/webhooks/data/response/webhooks_response.dart';

abstract class WebhooksRepository {
  Future<WebhooksResponse?> getWebhooksResponse({int? skip, int? top, String? monitorId, DateTime? searchedAt});
}
