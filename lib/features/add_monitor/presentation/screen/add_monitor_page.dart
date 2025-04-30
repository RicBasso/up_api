import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_api/features/add_monitor/bloc/add_monitor_cubit.dart';
import 'package:up_api/features/add_monitor/bloc/add_monitor_state.dart';
import 'package:up_api/features/menu/presentation/screen/menu.dart';
import 'package:up_api/style/extension/up_api_extra_colors.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/error_messages/error_messages.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/widgets/app_bar_widget.dart';
import 'package:up_api/widgets/generic_error_box_widget.dart';
import 'package:up_api/widgets/input_widget.dart';
import 'package:up_api/widgets/internal_app_bar_widget.dart';
import 'package:up_api/widgets/loading_button_widget.dart';
import 'package:up_api/widgets/user_circle_avatar_widget.dart';

class AddMonitorPage extends StatelessWidget {
  const AddMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AddMonitorCubit(AddMonitorState()), child: const AddMonitorScreen());
  }
}

class AddMonitorScreen extends StatefulWidget {
  const AddMonitorScreen({super.key});

  @override
  State<AddMonitorScreen> createState() => _AddMonitorScreenState();
}

class _AddMonitorScreenState extends State<AddMonitorScreen> {
  late final TextEditingController nameController;
  late final TextEditingController urlController;

  @override
  void initState() {
    nameController = TextEditingController();
    urlController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InternalAppBarWidget(title: AppLocalizations.of(context)?.add_monitor_label ?? 'add_monitor_label',),
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
    return const Column(
      children: [
        UpApiSpacing.large,
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
                onChange: () => context.read<AddMonitorCubit>().cleanNameError(),
                controller: nameController,
                errorGetter:
                    (BuildContext context, AddMonitorState state) => ErrorMessages.getNameError(context, state.nameError),
              ),
              UpApiSpacing.spacingFormFields,
              _buildFieldText(AppLocalizations.of(context)?.name_label ?? 'name_label'),
              UpApiSpacing.spacingLabelField,
              _buildInput(
                onChange: () => context.read<AddMonitorCubit>().cleanNameError(),
                controller: nameController,
                errorGetter:
                    (BuildContext context, AddMonitorState state) => ErrorMessages.getNameError(context, state.nameError),
              ),
              UpApiSpacing.extraLarge,
              GenericErrorBoxWidget<AddMonitorCubit, AddMonitorState>(
                errorCodeSelector: (state) => state.error,
                errorMessageGetter: ErrorMessages.getServerError,
              ),
              BlocBuilder<AddMonitorCubit, AddMonitorState>(
                buildWhen: (p, c) => (p.isLoading != c.isLoading) || (p.completed != c.completed),
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.completed) _successMessage(context) else const SizedBox(),
                      LoadingButtonWidget(
                        isLoading: state.isLoading,
                        onPressed: () async {
                           await context.read<AddMonitorCubit>().saveChanges(
                            nameController.text,

                          );
                          if(state.completed) {
                            nameController.text = upapiSessionManager.user?.firstName ?? '';
                          }
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
    required String? Function(BuildContext context, AddMonitorState state) errorGetter,
    required void Function() onChange,
    bool isPassword = false,
  }) {
    return BlocBuilder<AddMonitorCubit, AddMonitorState>(
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
      color: Theme.of(context).extension<UpApiExtraColors>()!.onSuccess,
      border: Border.all(color: Theme.of(context).extension<UpApiExtraColors>()!.success),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline, color: Theme.of(context).extension<UpApiExtraColors>()!.success),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            AppLocalizations.of(context)?.modify_complete_label ?? 'modify_complete_label',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).extension<UpApiExtraColors>()!.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
