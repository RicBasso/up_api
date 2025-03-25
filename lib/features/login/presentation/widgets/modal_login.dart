import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/presentation/widgets/modal_register.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/show_modal_handler.dart';
import 'package:up_api/widgets/input_widget.dart';



class ModalLogin extends StatelessWidget {
  const ModalLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        alignment: Alignment.center,
        height: (
            MediaQuery.sizeOf(context).height -
            MediaQuery.of(context).padding.vertical
        ) * 0.65,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)?.login_page_title ?? 'login_page_title',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              _buildFormSection(context),
            ],
          ),
        ),
      ),
    );
  }

}

Widget _buildFormSection(BuildContext context) {
  return Padding(
    padding: UpApiPadding.mediumHorizontalPadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.email_label ?? 'email_label',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        UpApiSpacing.spacingLabelField,
        const InputWidget(),
        UpApiSpacing.spacingFormFields,
        Text(
          AppLocalizations.of(context)?.password_label ?? 'password_label',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        UpApiSpacing.spacingLabelField,
        const InputWidget(
          password: true,
        ),
        UpApiSpacing.medium,
        Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
              showModalHandler(context, ModalRegister());
            },
            child: Text(
              AppLocalizations.of(context)?.lost_password_label ?? 'lost_password_label',
            ),
          ),
        ),
        UpApiSpacing.extraLarge,
        ElevatedButton(
          onPressed: () {

          },
          child: Text(
            AppLocalizations.of(context)?.login_page_submit_button ?? 'login_page_submit_button',
          ),
        ),
        UpApiSpacing.extraLarge,
        Container(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
              showModalHandler(context, ModalRegister());
            },
            child: Text(
              AppLocalizations.of(context)?.sign_up_now_label ?? 'sign_up_now_label',
            ),
          ),
        ),
      ],
    ),
  );
}
