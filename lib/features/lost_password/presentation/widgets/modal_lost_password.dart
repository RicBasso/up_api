import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/presentation/widgets/modal_login.dart';
import 'package:up_api/features/lost_password/bloc/lost_password_cubit.dart';
import 'package:up_api/features/lost_password/bloc/lost_password_state.dart';
import 'package:up_api/features/lost_password/presentation/widgets/modal_lost_password_confirm.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/error_messages/error_messages.dart';
import 'package:up_api/utils/show_modal_handler.dart';
import 'package:up_api/widgets/generic_error_box_widget.dart';
import 'package:up_api/widgets/input_widget.dart';
import 'package:up_api/widgets/loading_button_widget.dart';

class ModalLostPassword extends StatelessWidget {
  const ModalLostPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LostPasswordCubit(LostPasswordState()), child: const LostPassword());
  }
}

class LostPassword extends StatefulWidget {
  const LostPassword({super.key});

  @override
  State<LostPassword> createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  late final TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        alignment: Alignment.center,
        height: (MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.vertical) * 0.50,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UpApiSpacing.large,
              _buildFormHeader(context),
              UpApiSpacing.medium,
              _buildFormSection(context),
              UpApiSpacing.medium,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)?.lost_password_label ?? 'lost_password_label',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Container(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
              showModalHandler(context, const ModalLogin());
            },
            child: Text(AppLocalizations.of(context)?.login_now_label ?? 'login_now_label'),
          ),
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
          _buildLostPasswordFieldText(AppLocalizations.of(context)?.email_label ?? 'email_label'),
          UpApiSpacing.spacingLabelField,
          _buildLostPasswordInput(
            onChange: () => context.read<LostPasswordCubit>().cleanEmailError(),
            controller: emailController,
            errorGetter:
                (BuildContext context, LostPasswordState state) =>
                    ErrorMessages.getEmailError(context, state.emailError),
          ),
          GenericErrorBoxWidget<LostPasswordCubit, LostPasswordState>(
            errorCodeSelector: (state) => state.error,
            errorMessageGetter: ErrorMessages.getServerError,
          ),
          UpApiSpacing.extraLarge,
          BlocBuilder<LostPasswordCubit, LostPasswordState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) {
              return LoadingButtonWidget(
                isLoading: state.isLoading,
                onPressed: () async {
                  bool result;
                  result = await context.read<LostPasswordCubit>().lostPassword(emailController.text);
                  if (result) {
                    GoRouter.of(context).pop();
                    showModalHandler(context, const LostPasswordConfirm());
                  }
                },
                child: Text(AppLocalizations.of(context)?.lost_password_submit_button ?? 'lost_password_submit_button'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLostPasswordInput({
    required TextEditingController controller,
    required String? Function(BuildContext context, LostPasswordState state) errorGetter,
    required void Function() onChange,
    bool isPassword = false,
  }) {
    return BlocBuilder<LostPasswordCubit, LostPasswordState>(
      builder: (context, state) {
        final errorText = errorGetter(context, state);
        return InputWidget(
          onChange: (p0) => onChange(),
          controller: controller,
          password: isPassword,
          errorText: errorText,
        );
      },
    );
  }

  Widget _buildLostPasswordFieldText(String text) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium);
  }
}
