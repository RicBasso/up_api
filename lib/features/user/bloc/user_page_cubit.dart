import 'package:up_api/features/user/bloc/user_page_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';

class UserPageCubit extends BaseCubit<UserPageState> {
  UserPageCubit(super.initialState);

  Future<void> saveChanges(String name, String surname, String email, String phone) async {
    final emailError = validateEmail(email);
    final nameError = validateName(name);
    final surnameError = validateName(surname);
    final phoneError = validatePhone(phone);
    final hasErrors = emailError + nameError + surnameError + phoneError > 0;
    emit(
      state.copyWith(emailError: emailError, nameError: nameError, surnameError: surnameError, phoneError: phoneError),
    );
    if (hasErrors) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.userUpdate(name, surname, email, phone);
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
