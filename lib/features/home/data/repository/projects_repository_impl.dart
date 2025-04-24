import 'package:up_api/features/home/data/repository/projects_repository.dart';
import 'package:up_api/features/home/data/response/projects_response.dart';
import 'package:up_api/utils/service/service_locator.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  @override
  Future<ProjectsResponse?> getProjectsResponse({int? skip, int? top, String? query, DateTime? searchedAt}) async {
    final response = await upapiDatasource.get(
      'projects',
      queryParameters: {r'$skip': skip, r'$top': top, 'text': query, 'createdAt': searchedAt},
      headers: {'Authorization': upapiTokenManager.getToken() ?? ''},
    );

    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      if (response.data != null) {
        return ProjectsResponse.fromJson(response.data!);
      }
    }
    return null;
  }
}
