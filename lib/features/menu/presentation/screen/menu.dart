import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => upapiGoRouter..pop()..go('/user'),//GoRouter.of(context).go('/user'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${upapiSessionManager.user?.firstName ?? ''} ${upapiSessionManager.user?.lastName ?? ''}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)?.go_to_profile_label ?? '',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              UpApiSpacing.large,
              ListTile(
                onTap: () => upapiGoRouter..pop()..go('/home'),
                contentPadding: EdgeInsets.zero,
                title: Text('Dashboard', style: TextStyle(color: Colors.white)),
              ),
              UpApiSpacing.horizontalDivider,
              const Spacer(),
              ListTile(
                onTap: () => upapiAuthentication.logout(),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Esci', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
