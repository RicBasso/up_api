import 'package:flutter/material.dart';

void showModalHandler(BuildContext context, Widget modalScreen) {
  Future.delayed(const Duration(milliseconds: 400), () {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      // Permette al contenuto di andare oltre la metà dello schermo
      barrierColor: Colors.transparent,
      enableDrag: false,
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: Navigator.of(context),
      ),
      builder: (context) => modalScreen,
    );
  });
}
