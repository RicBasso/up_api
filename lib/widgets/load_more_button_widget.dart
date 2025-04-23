import 'package:flutter/material.dart';

class LoadMoreButtonWidget extends StatelessWidget {
  const LoadMoreButtonWidget({
    required this.current,
    required this.total,
    required this.onPressed,
    super.key,
    this.finishedText = '',
    this.buttonText = '',
  });

  final int current;
  final int total;
  final VoidCallback onPressed;
  final String finishedText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    if (current >= total && total != 0) {
      return Center(child: Text(finishedText, style: Theme.of(context).textTheme.bodyMedium));
    }

    if (total != 0) {
      return Center(child: OutlinedButton(onPressed: onPressed, child: Text(buttonText)));
    }

    return const SizedBox();
  }
}
