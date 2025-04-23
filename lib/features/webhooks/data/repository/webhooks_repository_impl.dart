import 'package:up_api/features/webhooks/data/repository/webhooks_repository.dart';
import 'package:up_api/features/webhooks/data/response/webhooks_response.dart';
import 'package:up_api/utils/service/service_locator.dart';

class WebhooksRepositoryImpl implements WebhooksRepository {
  @override
  Future<WebhooksResponse?> getWebhooksResponse({int? skip, int? top, String? monitorId, DateTime? searchedAt}) async {
    final response = await upapiDatasource.get(
      'webhooks',
      queryParameters: {r'$skip': skip, r'$top': top, 'monitorId': monitorId, 'createdAt': searchedAt},
      headers: {'Authorization': upapiTokenManager.getToken() ?? ''},
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      if (response.data is Map<String, dynamic>) {
        return WebhooksResponse.fromJson(response.data as Map<String, dynamic>);
      }
    }
    return null;
  }
}
