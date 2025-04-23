import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/bloc/login_cubit.dart';
import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/features/lost_password/presentation/widgets/modal_lost_password.dart';
import 'package:up_api/features/register/presentation/widgets/modal_register.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/error_messages/error_messages.dart';
import 'package:up_api/utils/show_modal_handler.dart';
import 'package:up_api/widgets/generic_error_box_widget.dart';
import 'package:up_api/widgets/input_widget.dart';
import 'package:up_api/widgets/loading_button_widget.dart';

class ModalLogin extends StatelessWidget {
  const ModalLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LoginCubit(LoginState()), child: const _LoginScreen());
  }
}

class _LoginScreen extends StatefulWidget {
  const _LoginScreen();

  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: Container(
        alignment: Alignment.center,
        height: (media.size.height - media.padding.vertical) * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UpApiSpacing.large,
              _buildHeader(context),
              UpApiSpacing.medium,
              _buildFormSection(context),
              UpApiSpacing.medium,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)?.login_page_title ?? 'login_page_title',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
            showModalHandler(context, const ModalRegister());
          },
          child: Text(AppLocalizations.of(context)?.register_now_label ?? 'register_now_label'),
        ),
      ],
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Padding(
      padding: UpApiPadding.mediumHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(context, AppLocalizations.of(context)?.email_label ?? 'email_label'),
          UpApiSpacing.spacingLabelField,
          _buildInput(
            controller: emailController,
            onChange: () => context.read<LoginCubit>().cleanEmailError(),
            errorGetter: (ctx, state) => ErrorMessages.getEmailError(ctx, state.emailError),
          ),
          UpApiSpacing.spacingFormFields,
          _fieldLabel(context, AppLocalizations.of(context)?.password_label ?? 'password_label'),
          UpApiSpacing.spacingLabelField,
          _buildInput(
            controller: passController,
            isPassword: true,
            onChange: () => context.read<LoginCubit>().cleanPassError(),
            errorGetter: (ctx, state) => ErrorMessages.getPasswordErrorLogin(ctx, state.passError),
          ),
          UpApiSpacing.medium,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
                showModalHandler(context, const ModalLostPassword());
              },
              child: Text(AppLocalizations.of(context)?.lost_password_label ?? 'lost_password_label'),
            ),
          ),
          GenericErrorBoxWidget<LoginCubit, LoginState>(
            errorCodeSelector: (state) => state.error,
            errorMessageGetter: ErrorMessages.getServerError,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (p, c) => (p.isLoading != c.isLoading) || (p.error != c.error),
            builder: (context, state) {
              return Column(
                children: [
                  if (state.error == null) UpApiSpacing.extraLarge else const SizedBox(),
                  LoadingButtonWidget(
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<LoginCubit>().login(emailController.text, passController.text);
                    },
                    child: Text(AppLocalizations.of(context)?.login_page_submit_button ?? 'login_page_submit_button'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium);
  }

  Widget _buildInput({
    required TextEditingController controller,
    required void Function() onChange,
    required String? Function(BuildContext context, LoginState state) errorGetter,
    bool isPassword = false,
  }) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final errorText = errorGetter(context, state);
        return InputWidget(
          controller: controller,
          password: isPassword,
          onChange: (_) => onChange(),
          errorText: errorText,
        );
      },
    );
  }
}
