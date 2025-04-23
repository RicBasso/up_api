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

  static String? getPasswordErrorLogin(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_password_empty;
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

  static String? getPhoneError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_phone_1;
      case 2:
        return AppLocalizations.of(context)?.error_phone_2;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getSubmitLoginError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_register_1;
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

  static String? getSubmitLostPasswordError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_lost_password_1;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getSubmitUserUpdateError(BuildContext context, int err) {
    switch (err) {
      case 0:
        return null;
      case 1:
        return AppLocalizations.of(context)?.error_user_update_1;
    }
    return AppLocalizations.of(context)?.error_generic;
  }

  static String? getServerError(BuildContext context, String? err) {
    if (err == null) return null;

    final loc = AppLocalizations.of(context);

    switch (err) {
      case 'LENGTH_NOT_SETTED':
        return loc?.length_not_setted ?? 'length_not_setted';

      case 'OFFSET_NOT_SETTED':
        return loc?.offset_not_setted ?? 'offset_not_setted';

      case 'USER_DISABLED':
        return loc?.user_disabled ?? 'user_disabled';

      case 'USER_NOT_CONFIRMED':
        return loc?.user_not_confirmed ?? 'user_not_confirmed';

      case 'INCORRECT_PASSWORD':
        return loc?.incorrect_password ?? 'incorrect_password';

      case 'USER_NOT_FOUND':
        return loc?.user_not_found ?? 'user_not_found';

      case 'USER_ALREADY_EXIST':
        return loc?.user_already_exist ?? 'user_already_exist';

      case 'RESET_TOKEN_NOT_VALID':
        return loc?.reset_token_not_valid ?? 'reset_token_not_valid';

      case 'RESET_TOKEN_EXPIRED':
        return loc?.reset_token_expired ?? 'reset_token_expired';

      case 'INVALID_REFRESH_TOKEN':
        return loc?.invalid_refresh_token ?? 'invalid_refresh_token';

      case 'USER_LEVEL_NOT_FOUND':
        return loc?.user_level_not_found ?? 'user_level_not_found';

      case 'USER_EMAIL_ALREADY_USE':
        return loc?.user_email_already_use ?? 'user_email_already_use';

      case 'COMPANY_NAME_EXISTS':
        return loc?.company_name_exists ?? 'company_name_exists';

      case 'PRODUCT_TYPES_NAME_EXISTS':
        return loc?.product_types_name_exists ?? 'product_types_name_exists';

      case 'PRODUCT_NAME_EXISTS':
        return loc?.product_name_exists ?? 'product_name_exists';

      case 'CUSTOMER_NAME_EXISTS':
        return loc?.customer_name_exists ?? 'customer_name_exists';

      case 'ORDER_ALREADY_EXISTS':
        return loc?.order_already_exists ?? 'order_already_exists';

      case 'SITE_ALREADY_EXISTS':
        return loc?.site_already_exists ?? 'site_already_exists';

      case 'CAMPAIGN_ALREADY_EXISTS':
        return loc?.campaign_already_exists ?? 'campaign_already_exists';

      case 'INVOICE_ALREADY_EXISTS':
        return loc?.invoice_already_exists ?? 'invoice_already_exists';

      case 'PAYOUT_HIGHER_THAN_PAYABLE':
        return loc?.payout_higher_than_payable ?? 'payout_higher_than_payable';

      case 'CONVERSATION_ALREADY_EXISTS':
        return loc?.conversation_already_exists ?? 'conversation_already_exists';

      case 'MESSAGES_ALREADY_EXISTS':
        return loc?.messages_already_exists ?? 'messages_already_exists';

      case 'CREDIT_CARD_NAME_EXISTS':
        return loc?.credit_card_name_exists ?? 'credit_card_name_exists';

      case 'STRIPE_CUSTOMER_ID_NOT_FOUND':
        return loc?.stripe_customer_id_not_found ?? 'stripe_customer_id_not_found';

      case 'STRIPE_PAYMENT_METHOD_MISSING':
        return loc?.stripe_payment_method_missing ?? 'stripe_payment_method_missing';

      case 'STRIPE_PAYMENT_INTENT_ERROR':
        return loc?.stripe_payment_intent_error ?? 'stripe_payment_intent_error';

      case 'STRIPE_PAYMENT_CHARGE_ERROR':
        return loc?.stripe_payment_charge_error ?? 'stripe_payment_charge_error';

      case 'STRIPE_NO_METHODS_ERROR':
        return loc?.stripe_no_methods_error ?? 'stripe_no_methods_error';

      case 'CREDIT_CARD_NOT_FOUND':
        return loc?.credit_card_not_found ?? 'credit_card_not_found';

      case 'STRIPE_SETUP_INTENT_ERROR':
        return loc?.stripe_setup_intent_error ?? 'stripe_setup_intent_error';

      case 'CONVERSATION_ORDER_EXISTS':
        return loc?.conversation_order_exists ?? 'conversation_order_exists';

      case 'PRODUCT_NOT_APPROVED_YET':
        return loc?.product_not_approved_yet ?? 'product_not_approved_yet';

      case 'CONNECTION_ERROR':
        return loc?.no_internet_connection ?? 'no_internet_connection';

      default:
        // errore non gestito: puoi loggare o restituire un default generico
        return loc?.error_generic ?? 'error_generic';
    }
  }
}
