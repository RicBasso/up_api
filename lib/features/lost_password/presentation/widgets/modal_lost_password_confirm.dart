import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/features/login/presentation/widgets/modal_login.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/utils/show_modal_handler.dart';

class ModalLostPasswordConfirm extends StatelessWidget {
  const ModalLostPasswordConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return const LostPasswordConfirm();
  }
}

class LostPasswordConfirm extends StatelessWidget {
  const LostPasswordConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        alignment: Alignment.center,
        height: (MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.vertical) * 0.50,
        child: SingleChildScrollView(
          child: Column(
            children: [
              UpApiSpacing.large,
              _buildHeader(context),
              UpApiSpacing.medium,
              _buildSection(context),
              UpApiSpacing.medium,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      AppLocalizations.of(context)?.lost_password_confirm_label ?? 'lost_password_confirm_label',
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget _buildSection(BuildContext context) {
    return TextButton(
      onPressed: () {
        GoRouter.of(context).pop();
        showModalHandler(context, const ModalLogin());
      },
      child: Text(AppLocalizations.of(context)?.login_now_label ?? 'login_now_label'),
    );
  }
}
