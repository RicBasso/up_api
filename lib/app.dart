import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_api/features/connection/cubit/connection_cubit.dart';
import 'package:up_api/features/connection/cubit/connection_state.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/app_preferences_cubit.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/app_preferences_state.dart';
import 'package:up_api/style/up_api_dark_theme.dart';
import 'package:up_api/style/up_api_theme.dart';
import 'package:up_api/utils/service/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConnectionCubit(ConnectionInternalState()),
          ),
          BlocProvider(
            create: (context) => AppPreferencesCubit(AppPreferencesState()),
          ),
        ],
        child: Builder(
          builder: (context) {
            return BlocListener<ConnectionCubit, ConnectionInternalState>(
              listener: _connectionHandler,
              child: BlocBuilder<AppPreferencesCubit, AppPreferencesState>(
                builder: (context, state) {
                  return MaterialApp.router(
                    theme: UpApiTheme.myTheme,
                    darkTheme: UpApiDarkTheme.myTheme,
                    themeMode: state.onDark ? ThemeMode.dark : ThemeMode.light,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: Locale(state.location),
                    routerConfig: upapiGoRouter,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

void _connectionHandler(BuildContext context, ConnectionInternalState state) {
  if (!state.isConnected) {
    BuildContext ctx;
    if (upapiSessionManager.navigatorKey.currentContext != null) {
      ctx = upapiSessionManager.navigatorKey.currentContext!;
    } else {
      return;
    }
    showDialog<void>(
      barrierDismissible: false,
      context: ctx,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)?.no_internet_connection ?? 'no_internet_connection'),
            content: Text(AppLocalizations.of(context)?.check_internet_connection ?? 'check_internet_connection'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await context.read<ConnectionCubit>().refreshConnection();
                },
                child: Text(AppLocalizations.of(context)?.retry_label ?? 'retry_label'),
              ),
            ],
          ),
        );
      },
    );
  }
}
