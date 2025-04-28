import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/theme_mode_switcher_cubit.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/service/service_locator.dart';

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
                title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
              ),
              UpApiSpacing.horizontalDivider,
              const Spacer(),
              Row(
                children: [
                  Flexible(
                    child: ListTile(
                      onTap: () => upapiAuthentication.logout(),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text('Esci', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  IconButton(onPressed:
                      () {
                    context.read<ThemeModeSwitcherCubit>().switchMode();
                  }, icon: context.read<ThemeModeSwitcherCubit>().onDark ? const Icon(Icons.dark_mode, color: Colors.white,) : const Icon(Icons.light_mode, color: Colors.white,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
