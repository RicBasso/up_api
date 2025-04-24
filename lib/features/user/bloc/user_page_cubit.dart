import 'package:up_api/features/user/bloc/user_page_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';

class UserPageCubit extends BaseCubit<UserPageState> {
  UserPageCubit(super.initialState);

  Future<void> saveChanges(String name, String surname, String email, String phone) async {
    final nameTrimmed = name.trim();
    final surnameTrimmed = surname.trim();
    final emailTrimmed = email.trim();
    final phoneTrimmed = phone.trim();
    final nameError = validateName(nameTrimmed);
    final surnameError = validateName(surnameTrimmed);
    final emailError = validateEmail(emailTrimmed);
    final phoneError = validatePhone(phoneTrimmed);
    final hasErrors = nameError + emailError +  surnameError + phoneError > 0;
    emit(
      state.copyWith(nameError: nameError, surnameError: surnameError, emailError: emailError, phoneError: phoneError),
    );
    if (hasErrors) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.userUpdate(nameTrimmed, surnameTrimmed, emailTrimmed, phoneTrimmed);
    if (res == null) {
      emit(UserPageState(error: 'GENERIC_ERROR'));
    }
    if (res?.success ?? false) {
      upapiSessionManager.user = res?.user;
      emit(UserPageState(completed: true));
      return;
    } else {
      emit(UserPageState(error: res?.code));
    }

    return;
  }

  void cleanNameError() {
    emit(state.copyWith(nameError: 0, nullError: true, completed: false));
  }

  void cleanSurnameError() {
    emit(state.copyWith(surnameError: 0, nullError: true, completed: false));
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, nullError: true, completed: false));
  }

  void cleanPhoneError() {
    emit(state.copyWith(phoneError: 0, nullError: true, completed: false));
  }
}
