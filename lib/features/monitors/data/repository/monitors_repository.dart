import 'package:up_api/features/home/data/response/projects_response.dart';

abstract class MonitorsRepository {
  Future<ProjectsResponse?> getMonitorsResponse();
}

