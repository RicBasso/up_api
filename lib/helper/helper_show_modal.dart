import 'package:flutter/material.dart';



void showModalHandler( context, modalScreen){
  showModalBottomSheet(
    useSafeArea: true,
    context: context,
    isScrollControlled: true, // Permette al contenuto di andare oltre la metà dello schermo
    barrierColor: Colors.transparent,
    enableDrag: false,
    transitionAnimationController: AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: Navigator.of(context),
    ),
    builder: (context) => modalScreen,
  );
}