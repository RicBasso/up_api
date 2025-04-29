import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/app_preferences_cubit.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/widgets/language_selector_widget.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
                  ),
                  GestureDetector(
                    onTap:
                        () =>
                            upapiGoRouter
                              ..pop()
                              ..go('/user'), //GoRouter.of(context).go('/user'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${upapiSessionManager.user?.firstName ?? ''} ${upapiSessionManager.user?.lastName ?? ''}',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        Text(
                          AppLocalizations.of(context)?.go_to_profile_label ?? '',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              UpApiSpacing.large,
              ListTile(
                onTap:
                    () =>
                        upapiGoRouter
                          ..pop()
                          ..go('/home'),
                contentPadding: EdgeInsets.zero,
                title: Text(AppLocalizations.of(context)?.home_page_title ?? 'home_page_title', style: const TextStyle(color: Colors.white)),
              ),
              UpApiSpacing.horizontalDivider,
              ListTile(
                onTap: () => _confirmBoxHandler(context),
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(Icons.logout, color: Colors.white),
                title: Text(
                  AppLocalizations.of(context)?.logout_label ?? 'logout_label',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              UpApiSpacing.horizontalDivider,
              const Spacer(),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                      child: LanguageSelectorWidget(),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 50,
                    child: IconButton(
                      alignment: AlignmentDirectional.centerEnd,
                      onPressed:
                        () {
                      context.read<AppPreferencesCubit>().switchThemeMode();
                    }, icon: Icon(context.read<AppPreferencesCubit>().onDark ? Icons.dark_mode : Icons.light_mode, color: Colors.white, size: 20,),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: _getAppVersion(),
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                      snapshot.data ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _confirmBoxHandler(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)?.logout_confirm_title ?? 'logout_confirm_title'),
      content: Text(AppLocalizations.of(context)?.logout_confirm_message ?? 'logout_confirm_message'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)?.cancel_label ?? 'cancel_label'),
        ),
        const SizedBox(width: 15,),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context)?.confirm_label ?? 'confirm_label'),
        ),
      ],
    ),
  );

  if (confirmed != null && confirmed == true) {
    upapiAuthentication.logout();
  }
}

Future<String> _getAppVersion() async{
  final packageInfo = await PackageInfo.fromPlatform();
  final version = packageInfo.version;
  final buildNumber = packageInfo.buildNumber;
  return 'v$version+$buildNumber';
}
