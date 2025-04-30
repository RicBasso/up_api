import 'package:flutter/material.dart';

class UserCircleAvatarWidget extends StatelessWidget {
  const UserCircleAvatarWidget({super.key, this.radius, this.iconSize});
  final double? radius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: radius ?? 25,
      maxRadius: radius ?? 25,
      backgroundImage: const AssetImage('assets/images/signup_background.png'),
      child: Icon(Icons.person, color: Theme.of(context).colorScheme.onSecondary, size: iconSize ?? 25,),
    );
  }
}
