import 'package:flutter/material.dart';
import 'package:up_api/utils/service/service_locator.dart';

void showModalHandler(BuildContext context, Widget modalScreen) {
  Future.delayed(const Duration(milliseconds: 400), () {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      useSafeArea: true,
      context: upapiSessionManager.keyWelcome?.currentState?.context ?? context,
      isScrollControlled: true,
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
