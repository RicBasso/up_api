import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericErrorBoxWidget<B extends BlocBase<S>, S> extends StatelessWidget {
  final String? Function(S state) errorCodeSelector;
  final String? Function(BuildContext context, String code) errorMessageGetter;

  const GenericErrorBoxWidget({
    Key? key,
    required this.errorCodeSelector,
    required this.errorMessageGetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        final errorCode = errorCodeSelector(state);
        if (errorCode != null) {
          final errorText = errorMessageGetter(context, errorCode);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onError,
              border: Border.all(color: Theme.of(context).colorScheme.error),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    errorText ?? 'error_text',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
