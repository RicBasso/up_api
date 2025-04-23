import 'package:up_api/features/home/data/response/projects_response.dart';

abstract class ProjectsRepository {
  Future<ProjectsResponse?> getProjectsResponse({int? skip, int? top, String? query, DateTime? searchedAt});
}
