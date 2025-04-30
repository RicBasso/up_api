import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, size: 40),
            color: Theme.of(context).colorScheme.onSecondary,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: SvgPicture.asset(
        'assets/images/up_api_logo_white.svg',
        semanticsLabel: 'My SVG Image',
      ),
      bottom: const PreferredSize(preferredSize: Size.fromHeight(10), child: SizedBox()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
