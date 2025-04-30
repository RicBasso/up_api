import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_api/style/extension/up_api_extra_colors.dart';
import 'package:up_api/style/up_api_spacing.dart';


class CardWidget extends StatelessWidget {
  const CardWidget({super.key, this.logoUrl, this.title, this.subTitle, this.description, this.result, this.onTap});

  final String? logoUrl;
  final String? title;
  final String? subTitle;
  final String? description;
  final String? result;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onTap != null || title != null) ...[
                Row(
                  children: [
                    if (logoUrl != null)
                      Row(children: [Image.network(logoUrl ?? '', width: 30), const SizedBox(width: 20)])
                    else
                      const SizedBox(),
                    Expanded(child: Text(title ?? '', style: Theme.of(context).textTheme.bodyLarge)),
                    if (onTap != null)
                      SvgPicture.asset(
                        'assets/images/chevron_right.svg',
                      )
                    else
                      const SizedBox(),
                  ],
                ),
                UpApiSpacing.large,
              ] else
                const SizedBox(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (subTitle != null) ...[
                          Text(subTitle!),
                          const SizedBox(height: 4),
                        ] else ...[
                          const SizedBox(),
                        ],
                        Text(description ?? '', style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  _resultMessage(result, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultMessage(String? result, BuildContext context) {

    if (result == null) return const SizedBox();

    final values = _ResultMessageValues(result, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: values.colorBack, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(values.icon, color: values.colorFront, size: 18),
          const SizedBox(width: 4),
          Text(
            values.text,
            style: TextStyle(color: values.colorFront, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ResultMessageValues {
  _ResultMessageValues(String message, BuildContext context) {
    switch (message) {
      case 'success':
        colorFront = Theme.of(context).extension<UpApiExtraColors>()!.success;
        colorBack = Theme.of(context).extension<UpApiExtraColors>()!.onSuccess;
        text = AppLocalizations.of(context)?.positive_result_label ?? 'positive_result_label';
        icon = Icons.check;

      case 'waiting_response':
        colorFront = Theme.of(context).extension<UpApiExtraColors>()!.attention;
        colorBack = Theme.of(context).extension<UpApiExtraColors>()!.attentionBackground;
        text = AppLocalizations.of(context)?.waiting_response_label ?? 'waiting_response_label';
        icon = Icons.warning_amber_outlined;

      case 'exception':
        colorFront = Theme.of(context).colorScheme.error;
        colorBack = Theme.of(context).colorScheme.onError;
        text = AppLocalizations.of(context)?.negative_result_label ?? 'negative_result_label';
        icon = Icons.close;

      case 'no_match':
        colorFront = Theme.of(context).colorScheme.error;
        colorBack = Theme.of(context).colorScheme.onError;
        text = AppLocalizations.of(context)?.negative_result_label ?? 'negative_result_label';
        icon = Icons.close;

      case 'error':
        colorFront = Theme.of(context).colorScheme.error;
        colorBack = Theme.of(context).colorScheme.onError;
        text = AppLocalizations.of(context)?.negative_result_label ?? 'negative_result_label';
        icon = Icons.close;

      case 'networkError':
        colorFront = Theme.of(context).colorScheme.error;
        colorBack = Theme.of(context).colorScheme.onError;
        text = AppLocalizations.of(context)?.negative_result_label ?? 'negative_result_label';
        icon = Icons.close;

      case 'generic_error':
        colorFront = Theme.of(context).colorScheme.error;
        colorBack = Theme.of(context).colorScheme.onError;
        text = AppLocalizations.of(context)?.negative_result_label ?? 'negative_result_label';
        icon = Icons.close;

      default:
        if (message.length >= 10) {
          colorFront = Theme.of(context).extension<UpApiExtraColors>()!.attention;
          colorBack = Theme.of(context).extension<UpApiExtraColors>()!.attentionBackground;
          text = AppLocalizations.of(context)?.positive_result_label ?? 'positive_result_label';
          icon = Icons.check;
        } else {
          colorFront = Theme.of(context).colorScheme.error;
          colorBack = Theme.of(context).colorScheme.onError;
          text = 'xxxxxxxxx';
          icon = Icons.warning_amber_outlined;
        }
    }
  }
  late Color colorFront;
  late Color colorBack;
  late String text = '';
  late IconData icon = Icons.warning_amber_outlined;
}
