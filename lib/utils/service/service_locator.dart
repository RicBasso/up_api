import 'package:get_it/get_it.dart';
import 'package:go_router/src/router.dart';
import 'package:up_api/features/home/data/repository/projects_repository.dart';
import 'package:up_api/features/home/data/repository/projects_repository_impl.dart';
import 'package:up_api/features/login/data/repository/authentication_repository.dart';
import 'package:up_api/features/login/data/repository/authentication_repository_impl.dart';
import 'package:up_api/utils/datasource/datasource.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';
import 'package:up_api/utils/session_manager.dart';

void registerDependencies(GoRouter router) {
  getIt.registerSingleton<SessionManager>(SessionManager());
  getIt.registerSingleton<Datasource>(UpapiDatasource());
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl());
  getIt.registerSingleton<GoRouter>(router);
  getIt.registerFactory<ProjectsRepository>(() => ProjectsRepositoryImpl());
}
final GetIt getIt = GetIt.instance;

Datasource get upapiDatasource => getIt.get<Datasource>();
AuthenticationRepository get upapiAuthentication =>
    getIt.get<AuthenticationRepository>();
GoRouter get upapiGoRouter => getIt.get<GoRouter>();
SessionManager get upapiSessionManager => getIt.get<SessionManager>();
ProjectsRepository get upapiProjectsRepository => getIt.get<ProjectsRepository>();
