import 'package:up_api/features/monitors/data/response/monitors_response.dart';

abstract class MonitorsRepository {
  Future<MonitorsResponse?> getMonitorsResponse({int? skip, int? top, String? query, String? projectId});
}
