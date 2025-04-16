import 'package:flutter/material.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/**
 *TODO () INSERIRE CONSTANTI DELLO STYLE NEL TEMA E RICHIARE QUELLE
 */

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.logoUrl,
    this.title,
    this.subTitle,
    this.description,
    this.result,
    this.onTap,
  });

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
                    Row(
                      children: [
                        Image.network(logoUrl ?? '', width: 30),
                        const SizedBox(width: 20),
                      ],
                    )
                  else
                    const SizedBox(),
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  if (onTap != null) Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ) else const SizedBox(),
                ],
              ),
                UpApiSpacing.large,
              ] else const SizedBox(),
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
                        Text(
                          description ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  /*if (result != null)*/ _resultMessage(result, context) /*else const SizedBox()*/,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultMessage(String? result, BuildContext context) {
    final values = _ResultMessageValues(result,context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(values.colorBack),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(values.icon, color: Color(values.colorFront), size: 18),
          const SizedBox(width: 4),
          Text(
            values.text,
            style: TextStyle(
              color: Color(values.colorFront),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


class _ResultMessageValues{


  _ResultMessageValues(String? message, BuildContext context){
    switch (message){
      case 'success':
        colorFront = 0xFF4CAF50;
        colorBack = 0xB0D3FFCC;
        text = AppLocalizations.of(context)?.positive_result_label ??
            'positive_result_label';
        icon = Icons.check;

      case 'waiting_response':
        colorFront = 0xFF000000;
        colorBack = 0xFFFFF9C4;
        text = AppLocalizations.of(context)?.waiting_response_label ?? 'waiting_response_label';
        icon = Icons.warning_amber_outlined;

      case 'exception':
        colorFront = 0xFFFF0000;
        colorBack = 0xFFFFEBEB;
        text = AppLocalizations.of(context)?.negative_result_label ??
            'negative_result_label';
        icon = Icons.close;

      case 'no_match':
        colorFront = 0xFFFF0000;
        colorBack = 0xFFFFEBEB;
        text = AppLocalizations.of(context)?.negative_result_label ??
            'negative_result_label';
        icon = Icons.close;

      case 'error':
        colorFront = 0xFFFF0000;
        colorBack = 0xFFFFEBEB;
        text = AppLocalizations.of(context)?.negative_result_label ??
            'negative_result_label';
        icon = Icons.close;

      case 'networkError':
        colorFront = 0xFFFF0000;
        colorBack = 0xFFFFEBEB;
        text = AppLocalizations.of(context)?.negative_result_label ??
            'negative_result_label';
        icon = Icons.close;

      case 'generic_error':
        colorFront = 0xFFFF0000;
        colorBack = 0xFFFFEBEB;
        text = AppLocalizations.of(context)?.negative_result_label ??
            'negative_result_label';
        icon = Icons.close;

      case null:
        colorFront = 0xFF000000;
        colorBack = 0xFFFFF9C4;
        text = AppLocalizations.of(context)?.unknown_response_label ?? 'unknown_response_label';
        icon = Icons.warning_amber_outlined;

      default:
        if (message.length >= 10){
          colorFront = 0xFF4CAF50;
          colorBack = 0xB0D3FFCC;
          text = AppLocalizations.of(context)?.positive_result_label ??
              'positive_result_label';
          icon = Icons.check;
        }else{
          colorFront = 0xFF000000;
          colorBack = 0xFFFFF9C4;
          text = 'xxxxxxxxx';
          icon = Icons.warning_amber_outlined;
        }

    }


  }
  late int colorFront = 0xFF000000;
  late int colorBack = 0xFFFFF9C4;
  late String text = '';
  late IconData icon = Icons.warning_amber_outlined;
}
