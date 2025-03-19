import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/screens/login_page.dart';
import 'package:up_api/theme/up_api_theme.dart';

Future<void> main() async {
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
      routerConfig: _router,
    );
  }
}

