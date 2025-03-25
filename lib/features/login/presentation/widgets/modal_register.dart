import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/presentation/widgets/modal_login.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/show_modal_handler.dart';



class ModalRegister extends StatelessWidget {
  ModalRegister({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Evita che la tastiera copra il contenuto
      ),
      child: Container(
        alignment: Alignment.center,
        height: (MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.vertical) * 0.65,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                      showModalHandler(context, const ModalLogin());
                  },
                  child: const Text('Accedi'),
                ),
                Text(
                  AppLocalizations.of(context)?.login_page_title ?? 'login_page_title',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Padding(
                  padding: UpApiPadding.mediumHorizontalPadding,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.email_label ?? 'email_label',
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
                        ),
                        UpApiSpacing.spacingFormFields,
                        Text(
                          AppLocalizations.of(context)?.password_label ?? 'password_label',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        UpApiSpacing.spacingLabelField,
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        UpApiSpacing.spacingFormFields,
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('ho cliccato');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)?.login_page_submit_button ?? 'login_page_submit_button',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
