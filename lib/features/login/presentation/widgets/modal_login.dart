import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/bloc/login_cubit.dart';
import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/features/register/presentation/widgets/modal_register.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/show_modal_handler.dart';
import 'package:up_api/widgets/input_widget.dart';

final emailController = TextEditingController();
final passController = TextEditingController();

class ModalLogin extends StatelessWidget {
  const ModalLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginState()),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        alignment: Alignment.center,
        height:
            (MediaQuery.sizeOf(context).height -
                MediaQuery.of(context).padding.vertical) *
            0.80,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)?.login_page_title ??
                    'login_page_title',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              UpApiSpacing.large,
              _buildFormSection(context),
              UpApiSpacing.extraLarge,
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                    showModalHandler(context, const ModalRegister());
                  },
                  child: Text(
                    AppLocalizations.of(context)?.register_now_label ??
                        'sign_up_now_label',
                  ),
                ),
              ),
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
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return InputWidget(
              onChange: (p0) => context.read<LoginCubit>().cleanEmailError(),
              controller: emailController,
              errorText: state.emailError,
            );
          },
        ),
        UpApiSpacing.spacingFormFields,
        Text(
          AppLocalizations.of(context)?.password_label ?? 'password_label',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        UpApiSpacing.spacingLabelField,
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return InputWidget(
              onChange: (p0) => context.read<LoginCubit>().cleanPassError(),
              controller: passController,
              password: true,
              errorText: state.passError,
            );
          },
        ),
        UpApiSpacing.medium,
        Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
              showModalHandler(context, const ModalRegister());
            },
            child: Text(
              AppLocalizations.of(context)?.lost_password_label ??
                  'lost_password_label',
            ),
          ),
        ),
        UpApiSpacing.extraLarge,
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (p, c) => p.isLoading != c.isLoading,
          builder: (context, state) {
            return ElevatedButton(
              onPressed:
                  state.isLoading
                      ? null
                      : () {
                        context.read<LoginCubit>().login(
                          'gianluca+6@igsolutions.it',//emailController.text,
                          '00661944',//passController.text,
                          AppLocalizations.of(context)?.error_empty_email ??
                              'error_empty_email',
                          AppLocalizations.of(context)?.error_empty_pass ??
                              'error_empty_pass',
                          AppLocalizations.of(context)?.error_generic ??
                              'error_generic',
                        );
                      },
              child:
                  state.isLoading
                      ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onSecondary,
                      )
                      : Text(
                        AppLocalizations.of(
                              context,
                            )?.login_page_submit_button ??
                            'login_page_submit_button',
                      ),
            );
          },
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state.error != null) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onError,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.error,
                  ),
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
                        'Le credenziali inserite non sono corrette. Riprova controllando email e password.',
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
        ),
      ],
    ),
  );
}
