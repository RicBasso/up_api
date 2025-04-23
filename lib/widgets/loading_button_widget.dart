import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  LoadingButtonWidget({required this.child, super.key, this.isLoading = false, this.onPressed, this.overrideStyle});

  late final bool isLoading;
  late void Function()? onPressed;
  late Widget child;
  final ButtonStyle? overrideStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: overrideStyle ?? Theme.of(context).elevatedButtonTheme.style,
      child: isLoading ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onSecondary) : child,
    );
  }
}
