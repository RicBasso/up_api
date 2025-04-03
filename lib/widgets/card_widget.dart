import 'package:flutter/material.dart';
import 'package:up_api/style/up_api_spacing.dart';

class CardWidget extends StatelessWidget {

  const CardWidget({
    super.key,
    this.logoUrl,
    this.title,
    //this.subTitle,
    this.description,
    this.result,
  });

  final String? logoUrl;
  final String? title;
  //final String? subTitle;
  final String? description;
  final bool? result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0,4),
            blurRadius: 20,
          ),
        ],
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (logoUrl != null) Row(
                  children: [
                    Image.network(
                        logoUrl ?? '',
                        width: 30,
                    ),
                    const SizedBox(width: 20),
                  ],
                ) else const SizedBox(),
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
                    const Text(
                      'Ultimo check:',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                _resultMessage(result: result ?? false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultMessage({
    required bool result,
  }){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: result ? const Color(0xB0D3FFCC) : const Color(0xFFFFEBEB), // rosa chiaro
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (result) const Icon(
            Icons.check,
            color: Colors.green,
            size: 18,
          ) else const Icon(
            Icons.close,
            color: Colors.red,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            result ? 'Regolare' : 'Errore',
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
