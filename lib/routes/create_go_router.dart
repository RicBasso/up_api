import 'package:go_router/go_router.dart';
import 'package:up_api/features/home/presentation/screen/home_page.dart';
import 'package:up_api/features/welcome/presentation/screen/welcome_page.dart';
import 'package:up_api/routes/routes.dart';

GoRouter createGoRouter(){
  return GoRouter(
    initialLocation: Routes.welcome,
    routes: [
      GoRoute(path: Routes.welcome, builder: (context, state) => const WelcomePage()),
      GoRoute(path: Routes.homepage, builder: (context, state) => const HomePage()),
    ],
  );
}
