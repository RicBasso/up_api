import 'package:flutter/material.dart';
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
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome Utente',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      Text(
                        'Vai al tuo profilo',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              UpApiSpacing.large,
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Dashboard', style: TextStyle(color: Colors.white)),
              ),
              UpApiSpacing.horizontalDivider,
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Progetti', style: TextStyle(color: Colors.white)),
              ),
              UpApiSpacing.horizontalDivider,
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'La mia azienda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
