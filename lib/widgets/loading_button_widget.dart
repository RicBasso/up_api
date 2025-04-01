import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  LoadingButtonWidget({
    required this.child,
    super.key,
    this.isLoading = false,
    this.onPressed,
  });

  late final bool isLoading;
  late void Function()? onPressed;
  late Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
      isLoading ? null : onPressed,
      child:
      isLoading
          ? CircularProgressIndicator(
        color: Theme.of(context).colorScheme.onSecondary,
      )
          : child,
    );
  }
}
