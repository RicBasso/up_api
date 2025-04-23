import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_api/features/menu/presentation/screen/menu.dart';
import 'package:up_api/features/user/bloc/user_page_cubit.dart';
import 'package:up_api/features/user/bloc/user_page_state.dart';
import 'package:up_api/style/colors/up_api_colors_light.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/error_messages/error_messages.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/widgets/app_bar_widget.dart';
import 'package:up_api/widgets/generic_error_box_widget.dart';
import 'package:up_api/widgets/input_widget.dart';
import 'package:up_api/widgets/loading_button_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserPageCubit(UserPageState()), child: const UserScreen());
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final TextEditingController surnameController;
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    phoneController = TextEditingController();
    emailController.text = upapiSessionManager.user?.email ?? '';
    nameController.text = upapiSessionManager.user?.firstName ?? '';
    surnameController.text = upapiSessionManager.user?.lastName ?? '';
    phoneController.text = upapiSessionManager.user?.phone ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: const AppBarWidget(),
      body: SafeArea(
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
        CircleAvatar(
          backgroundImage: const AssetImage('assets/images/signup_background.png'),
          maxRadius: 40,
          minRadius: 40,
          child: Icon(size: 50, Icons.person, color: Theme.of(context).colorScheme.onSecondary),
        ),
        UpApiSpacing.large,
        Text(
          '${AppLocalizations.of(context)?.welcome_label ?? 'welcome_label'} ${upapiSessionManager.user?.firstName}',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Padding(
      padding: UpApiPadding.smallWiderPadding,
      child: Card(
        child: Padding(
          padding: UpApiPadding.mediumSymmetricPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldText(AppLocalizations.of(context)?.name_label ?? 'name_label'),
              UpApiSpacing.spacingLabelField,
              _buildInput(
                onChange: () => context.read<UserPageCubit>().cleanNameError(),
                controller: nameController,
                errorGetter:
                    (BuildContext context, UserPageState state) => ErrorMessages.getNameError(context, state.nameError),
              ),
              UpApiSpacing.spacingFormFields,
              _buildFieldText(AppLocalizations.of(context)?.surname_label ?? 'surname_label'),
              UpApiSpacing.spacingLabelField,
              _buildInput(
                onChange: () => context.read<UserPageCubit>().cleanSurnameError(),
                controller: surnameController,
                errorGetter:
                    (BuildContext context, UserPageState state) =>
                        ErrorMessages.getSurnameError(context, state.surnameError),
              ),
              UpApiSpacing.spacingFormFields,
              _buildFieldText(AppLocalizations.of(context)?.email_label ?? 'email_label'),
              UpApiSpacing.spacingLabelField,
              _buildInput(
                onChange: () => context.read<UserPageCubit>().cleanEmailError(),
                controller: emailController,
                errorGetter:
                    (BuildContext context, UserPageState state) =>
                        ErrorMessages.getEmailError(context, state.emailError),
              ),
              UpApiSpacing.spacingFormFields,
              _buildFieldText(AppLocalizations.of(context)?.phone_label ?? 'phone_label'),
              UpApiSpacing.spacingLabelField,
              _buildInput(
                onChange: () => context.read<UserPageCubit>().cleanPhoneError(),
                controller: phoneController,
                errorGetter:
                    (BuildContext context, UserPageState state) =>
                        ErrorMessages.getPhoneError(context, state.phoneError),
              ),
              UpApiSpacing.extraLarge,
              GenericErrorBoxWidget<UserPageCubit, UserPageState>(
                errorCodeSelector: (state) => state.error,
                errorMessageGetter: ErrorMessages.getServerError,
              ),
              BlocBuilder<UserPageCubit, UserPageState>(
                buildWhen: (p, c) => (p.isLoading != c.isLoading) || (p.completed != c.completed),
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.completed) _successMessage(context) else const SizedBox(),
                      LoadingButtonWidget(
                        isLoading: state.isLoading,
                        onPressed: () {
                          context.read<UserPageCubit>().saveChanges(
                            nameController.text,
                            surnameController.text,
                            emailController.text,
                            phoneController.text,
                          );
                        },
                        child: Text(AppLocalizations.of(context)?.save_label ?? 'save_label'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String? Function(BuildContext context, UserPageState state) errorGetter,
    required void Function() onChange,
    bool isPassword = false,
  }) {
    return BlocBuilder<UserPageCubit, UserPageState>(
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

  Widget _buildFieldText(String text) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium);
  }
}

Widget _successMessage(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onTertiary,
      border: Border.all(color: Theme.of(context).colorScheme.tertiary),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.error_outline, color: UpApiColorsLight.success),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            AppLocalizations.of(context)?.modify_complete_label ?? 'modify_complete_label',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
