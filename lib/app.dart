import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_api/style/up_api_dark_theme.dart';
import 'package:up_api/style/up_api_theme.dart';
import 'package:up_api/utils/service/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: MaterialApp.router(
        theme: UpApiTheme.myTheme,
        darkTheme: UpApiDarkTheme.myTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: upapiGoRouter,
      ),
    );
  }
}
