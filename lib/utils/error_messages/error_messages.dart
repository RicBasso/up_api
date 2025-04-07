import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorMessages {
  static String? getEmailError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_email_1;

      case 2:
        return AppLocalizations.of(context)?.error_email_2;

      case 3:
        return AppLocalizations.of(context)?.error_email_3;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getPasswordError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_password_1;
      case 2:
        return AppLocalizations.of(context)?.error_password_2;
      case 3:
        return AppLocalizations.of(context)?.error_password_3;
      case 4:
        return AppLocalizations.of(context)?.error_password_4;
      case 5:
        return AppLocalizations.of(context)?.error_password_5;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getNameError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_name_1;
      case 2:
        return AppLocalizations.of(context)?.error_name_2;
      case 3:
        return AppLocalizations.of(context)?.error_name_3;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getSurnameError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_surname_1;
      case 2:
        return AppLocalizations.of(context)?.error_surname_2;
      case 3:
        AppLocalizations.of(context)?.error_surname_3;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getBusinessError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_business_1;
      case 2:
        return AppLocalizations.of(context)?.error_business_2;
      case 3:
        return AppLocalizations.of(context)?.error_business_3;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getSubmitRegisterError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_register_1;
    }
    return AppLocalizations.of(context)?.error_generic;
  }
}
