import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_api/features/welcome/bloc/welcome_cubit.dart';
import 'package:up_api/utils/service/service_locator.dart';

void showModalHandler(BuildContext context, Widget modalScreen, double heightPercentage) {
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
    upapiSessionManager.keyWelcome?.currentState?.context.read<WelcomeCubit>().updatePercentage(heightPercentage);
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
