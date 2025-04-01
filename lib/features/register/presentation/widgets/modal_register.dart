import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/presentation/widgets/modal_login.dart';
import 'package:up_api/features/register/bloc/register_cubit.dart';
import 'package:up_api/features/register/bloc/register_state.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/error_messages/error_messages.dart';
import 'package:up_api/utils/show_modal_handler.dart';
import 'package:up_api/widgets/generic_error_box_widget.dart';
import 'package:up_api/widgets/input_widget.dart';
import 'package:up_api/widgets/loading_button_widget.dart';

class ModalRegister extends StatelessWidget {
  const ModalRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(RegisterState()),
      child: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController passController;
  late final TextEditingController surnameController;
  late final TextEditingController businessController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passController = TextEditingController();
    surnameController = TextEditingController();
    businessController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passController.dispose();
    surnameController.dispose();
    businessController.dispose();
    super.dispose();
  }

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
          AppLocalizations.of(context)?.sing_up_page_title ??
              'sing_up_page_title',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Container(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
              showModalHandler(context, const ModalLogin());
            },
            child: Text(
              AppLocalizations.of(context)?.login_now_label ??
                  'login_now_label',
            ),
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
          _buildRegisterFieldText(
              AppLocalizations.of(context)?.email_label ?? 'email_label',
          ),
          UpApiSpacing.spacingLabelField,
          _buildRegisterInput(
            onChange: () => context.read<RegisterCubit>().cleanEmailError(),
            controller: emailController,
            errorGetter:
                (BuildContext context, RegisterState state) =>
                    ErrorMessages.getEmailError(context, state.emailError),
          ),
          UpApiSpacing.spacingFormFields,
          _buildRegisterFieldText(
            AppLocalizations.of(context)?.password_label ?? 'password_label',
          ),
          UpApiSpacing.spacingLabelField,
          _buildRegisterInput(
            onChange: () => context.read<RegisterCubit>().cleanPassError(),
            isPassword: true,
            controller: passController,
            errorGetter:
                (BuildContext context, RegisterState state) =>
                    ErrorMessages.getPasswordError(context, state.passError),
          ),
          UpApiSpacing.spacingFormFields,
          _buildRegisterFieldText(
            AppLocalizations.of(context)?.name_label ?? 'name_label',
          ),
          UpApiSpacing.spacingLabelField,
          _buildRegisterInput(
            onChange: () => context.read<RegisterCubit>().cleanNameError(),
            controller: nameController,
            errorGetter:
                (BuildContext context, RegisterState state) =>
                    ErrorMessages.getNameError(context, state.nameError),
          ),
          UpApiSpacing.spacingFormFields,
          _buildRegisterFieldText(
            AppLocalizations.of(context)?.surname_label ?? 'surname_label',
          ),
          UpApiSpacing.spacingLabelField,
          _buildRegisterInput(
            onChange: () => context.read<RegisterCubit>().cleanSurnameError(),
            controller: surnameController,
            errorGetter:
                (BuildContext context, RegisterState state) =>
                    ErrorMessages.getSurnameError(context, state.surnameError),
          ),
          UpApiSpacing.spacingFormFields,
          _buildRegisterFieldText(
            AppLocalizations.of(context)?.business_label ?? 'business_label',
          ),
          UpApiSpacing.spacingLabelField,
          _buildRegisterInput(
            onChange: () => context.read<RegisterCubit>().cleanBusinessError(),
            controller: businessController,
            errorGetter:
                (BuildContext context, RegisterState state) =>
                    ErrorMessages.getBusinessError(
                      context,
                      state.businessError,
                    ),
          ),
          UpApiSpacing.extraLarge,
          GenericErrorBoxWidget<RegisterCubit, RegisterState>(
            errorCodeSelector: (state) => state.error,
            errorMessageGetter: ErrorMessages.getSubmitRegisterError,
          ),
          BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) {
              return LoadingButtonWidget(
                isLoading: state.isLoading,
                onPressed: () {
                  context.read<RegisterCubit>().register(
                    emailController.text,
                    passController.text,
                    'test',//nameController.text,
                    'test',//surnameController.text,
                    'test',//businessController.text,
                  );
                },
                child: Text(
                          AppLocalizations.of(
                                context,
                              )?.register_page_submit_button ??
                              'register_page_submit_button',
                        ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterInput({
    required TextEditingController controller,
    required String? Function(BuildContext context, RegisterState state) errorGetter,
    required void Function() onChange,
    bool isPassword = false,
  }) {
    return BlocBuilder<RegisterCubit, RegisterState>(
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



  Widget _buildRegisterFieldText(String text){
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

}
