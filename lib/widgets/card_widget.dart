import 'package:flutter/material.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///TODO () INSERIRE CONSTANTI DELLO STYLE NEL TEMA E RICHIARE QUELLE

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.logoUrl,
    this.title,
    //this.subTitle,
    this.description,
    this.result,
    this.onTap,
  });

  final String? logoUrl;
  final String? title;
  //final String? subTitle;
  final String? description;
  final bool? result;
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
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              UpApiSpacing.large,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)?.last_check_label ??
                          'last_check_label',),
                      const SizedBox(height: 4),
                      Text(
                        description ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  _resultMessage(result ?? false, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultMessage(bool result, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color:
            result
                ? const Color(0xB0D3FFCC)
                : const Color(0xFFFFEBEB), // rosa chiaro
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (result)
            const Icon(Icons.check, color: Colors.green, size: 18)
          else
            const Icon(Icons.close, color: Colors.red, size: 18),
          const SizedBox(width: 4),
          Text(
            result ?  AppLocalizations.of(context)?.positive_result_label ??
                'positive_result_label' : AppLocalizations.of(context)?.negative_result_label ??
                'negative_result_label',
            style: TextStyle(
              color: result ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
