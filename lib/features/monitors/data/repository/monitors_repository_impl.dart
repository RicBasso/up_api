import 'package:up_api/features/monitors/data/repository/monitors_repository.dart';
import 'package:up_api/features/monitors/data/response/monitors_response.dart';
import 'package:up_api/utils/service/service_locator.dart';

class MonitorsRepositoryImpl implements MonitorsRepository {
  @override
  Future<MonitorsResponse?> getMonitorsResponse({int? skip, int? top, String? query, String? projectId, DateTime? searchedAt}) async {
    final response = await upapiDatasource.get(
      'monitors',
      queryParameters: {r'$skip': skip, r'$top': top, 'text': query, 'projectId': projectId, 'createdAt': searchedAt},
      headers: {'Authorization': upapiTokenManager.getToken() ?? ''},
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      if (response.data is Map<String, dynamic>) {
        return MonitorsResponse.fromJson(response.data as Map<String, dynamic>);
      }
    }
    return null;
  }
}
