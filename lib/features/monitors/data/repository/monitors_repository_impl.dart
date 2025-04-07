import 'package:up_api/features/home/data/repository/projects_repository.dart';
import 'package:up_api/features/home/data/response/projects_response.dart';
import 'package:up_api/features/monitors/data/repository/monitors_repository.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';
import 'package:up_api/utils/service/service_locator.dart';

class MonitorsRepositoryImpl implements MonitorsRepository {
  @override
  Future<ProjectsResponse?> getMonitorsResponse() async {
    print("getMonitorsResponse reposirty");
    final response = await upapiDatasource.get('monitors');

    if (response != null &&
        (response.statusCode ?? 100) >= 200 &&
        (response.statusCode ?? 400) < 300) {
      if (response.data is Map<String, dynamic>) {
        return ProjectsResponse.fromJson(response.data as Map<String, dynamic>);
      }
    }
    return null;
  }
}
