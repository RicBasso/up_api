import 'package:flutter/material.dart';

class InternalAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const InternalAppBarWidget({this.title, super.key});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      iconTheme: const IconThemeData(color: Colors.white, size: 40),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(
        title ?? '',
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontWeight: FontWeight.w700),
      ),
      bottom: const PreferredSize(preferredSize: Size.fromHeight(10), child: SizedBox()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
