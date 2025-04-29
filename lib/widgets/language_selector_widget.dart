import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/app_preferences_cubit.dart';

class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
      focusColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      dropdownColor: Colors.black,
      menuWidth: 60,
      underline: const SizedBox(),
      icon: const SizedBox(),
      value: context.read<AppPreferencesCubit>().language,
      items: [
        DropdownMenuItem(
          value: 'en',
          child: Text(AppLocalizations.of(context)?.locale_en_label ?? 'locale_en_label'),
        ),
        DropdownMenuItem(
          value: 'it',
          child: Text(AppLocalizations.of(context)?.locale_it_label ?? 'locale_it_label'),
        ),
      ],
      onChanged: (value) {
        context.read<AppPreferencesCubit>().switchLanguage(value ?? 'en');
      },
    );
  }
}
