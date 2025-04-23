import 'package:get_it/get_it.dart';
import 'package:go_router/src/router.dart';
import 'package:up_api/features/home/data/repository/projects_repository.dart';
import 'package:up_api/features/home/data/repository/projects_repository_impl.dart';
import 'package:up_api/features/login/data/repository/authentication_repository.dart';
import 'package:up_api/features/login/data/repository/authentication_repository_impl.dart';
import 'package:up_api/features/monitors/data/repository/monitors_repository.dart';
import 'package:up_api/features/monitors/data/repository/monitors_repository_impl.dart';
import 'package:up_api/features/webhooks/data/repository/webhooks_repository.dart';
import 'package:up_api/features/webhooks/data/repository/webhooks_repository_impl.dart';
import 'package:up_api/utils/datasource/datasource.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';
import 'package:up_api/utils/session_manager.dart';
import 'package:up_api/utils/shared_prefs.dart';
import 'package:up_api/utils/token_manager.dart';

Future<void> registerDependencies() async {
  final pref = SharedPrefs();
  await pref.init();

  getIt
    ..registerSingleton<SharedPrefs>(pref)
    ..registerLazySingleton<TokenManager>(TokenManager.new)
    ..registerSingleton<SessionManager>(SessionManager())
    ..registerSingleton<Datasource>(UpapiDatasource())
    ..registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl())
    ..registerFactory<ProjectsRepository>(ProjectsRepositoryImpl.new)
    ..registerFactory<MonitorsRepository>(MonitorsRepositoryImpl.new)
    ..registerFactory<WebhooksRepository>(WebhooksRepositoryImpl.new);
}

void registerRouter(GoRouter router) {
  getIt.registerSingleton<GoRouter>(router);
}

final GetIt getIt = GetIt.instance;

GoRouter get upapiGoRouter => getIt.get<GoRouter>();
SharedPrefs get sharedPrefs => getIt.get<SharedPrefs>();
TokenManager get upapiTokenManager => getIt.get<TokenManager>();
SessionManager get upapiSessionManager => getIt.get<SessionManager>();
Datasource get upapiDatasource => getIt.get<Datasource>();
AuthenticationRepository get upapiAuthentication => getIt.get<AuthenticationRepository>();
ProjectsRepository get upapiProjectsRepository => getIt.get<ProjectsRepository>();
MonitorsRepository get upapiMonitorsRepository => getIt.get<MonitorsRepository>();
WebhooksRepository get upapiWebhooksRepository => getIt.get<WebhooksRepository>();
