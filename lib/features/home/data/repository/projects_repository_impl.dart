import 'package:up_api/features/home/data/repository/projects_repository.dart';
import 'package:up_api/features/home/data/response/projects_response.dart';
import 'package:up_api/utils/service/service_locator.dart';

class ProjectsRepositoryImpl implements ProjectsRepository{
  @override
  Future<ProjectsResponse?> getProjectsResponse() async {
      final response = await upapiDatasource.get(
        'projects',
        headers: {'Authorization': upapiSessionManager.token ?? ''},
      );

      if (response != null &&
          (response.statusCode ?? 100) >= 200 &&
          (response.statusCode ?? 400) < 300) {
        if(response.data is Map<String, dynamic>){

          return ProjectsResponse.fromJson(response.data as Map<String, dynamic>);
        }
      }
      return null;
  }
}
