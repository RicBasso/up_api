import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/screens/login_page.dart';
import 'package:up_api/theme/up_api_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main(){
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: UpApiTheme.myTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}

