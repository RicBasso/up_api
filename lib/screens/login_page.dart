import 'package:flutter/material.dart';
import 'package:up_api/classes/up_api_spacing.dart';
import '../classes/up_api_padding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              AppLocalizations.of(context)?.login_page_title ?? "login_page_title",
              style: Theme.of(context).textTheme.headlineLarge
          ),
          Padding(
            padding: UpApiPadding.formPadding,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      AppLocalizations.of(context)?.email_label ?? "email_label",
                      style: Theme.of(context).textTheme.labelMedium
                  ),
                  UpApiSpacing.spacingLabelField,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  UpApiSpacing.spacingFormFields,
                  Text(
                    AppLocalizations.of(context)?.email_label ?? "password_label",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  UpApiSpacing.spacingLabelField,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  UpApiSpacing.spacingFormFields,
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (formKey.currentState!.validate()) {
                        print("ho cliccato");

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)?.login_page_submit_button ?? "login_page_submit_button",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
