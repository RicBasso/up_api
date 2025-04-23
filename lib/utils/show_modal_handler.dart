import 'package:flutter/material.dart';
import 'package:up_api/utils/service/service_locator.dart';

Future<void> showModalHandler(BuildContext context, Widget modalScreen) async {
  void showModal() {
    upapiSessionManager.animation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: Navigator.of(context),
      reverseDuration: const Duration(milliseconds: 500),
    );
    showModalBottomSheet<void>(
      isDismissible: false,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      useSafeArea: true,
      context: upapiSessionManager.keyWelcome?.currentState?.context ?? context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      enableDrag: false,
      transitionAnimationController: upapiSessionManager.animation,
      builder: (context) => modalScreen,
    );
  }

  if (upapiSessionManager.animation != null) {
    upapiSessionManager.animation?.addStatusListener((status) {
      if (status == AnimationStatus.dismissed || status == AnimationStatus.completed) {
        showModal();
      }
    });
    return;
  }
  showModal();
}
