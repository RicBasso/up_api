import 'package:go_router/go_router.dart';
import 'package:up_api/features/home/presentation/screen/home_page.dart';
import 'package:up_api/features/monitors/presentation/screen/monitors_page.dart';
import 'package:up_api/features/user/presentation/screen/user_page.dart';
import 'package:up_api/features/webhooks/presentation/screen/webhooks_page.dart';
import 'package:up_api/features/welcome/presentation/screen/welcome_page.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/service/service_locator.dart';

GoRouter createGoRouter(String initialPage) {

  return GoRouter(
    initialLocation: Routes.user,//initialPage,
    routes: [
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: Routes.homepage,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: Routes.monitors,
            //redirect: (context, state) => const HomePage(),/// TODO() redirect
            builder: (context, state)
            {
              final projectId = ((state.extra as Map<String,dynamic>)['projectId'] ?? '') as String;
              final projectName = ((state.extra as Map<String,dynamic>)['projectName'] ?? '') as String;
              return MonitorsPage(projectId: projectId, projectName: projectName,);
            },
            routes: [
              GoRoute(
                path: Routes.webhooks,
                builder: (context, state) {
                  final monitorId = state.pathParameters['monitorId'] ?? '';
                  final monitorName = ((state.extra as Map<String,dynamic>)['monitorName'] ?? '') as String;
                  return WebhooksPage(monitorId: monitorId, monitorName: monitorName,);
                },
              ),
            ]
          ),
        ],
      ),
      GoRoute(
        path: Routes.user,
        builder: (context, state) => const UserPage(),
      ),
    ],
  );
}
