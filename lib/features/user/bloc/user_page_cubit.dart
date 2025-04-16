import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/features/register/bloc/register_state.dart';
import 'package:up_api/features/user/bloc/user_page_state.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';

class UserPageCubit extends BaseCubit<UserPageState> {
  UserPageCubit(super.initialState);

  Future<void> saveChanges(
    String name,
    String surname,
    String email,
    String mobile,
  ) async {
    final emailError = validateEmail(email);
    final nameError = validateName(name);
    final surnameError = validateName(surname);
    final mobileError = validatePhone(mobile);
    final hasErrors =
        emailError  + nameError + surnameError + mobileError > 0;
    emit(
      state.copyWith(
        emailError: emailError,
        nameError: nameError,
        surnameError: surnameError,
        mobileError: mobileError,
      ),
    );
    if (hasErrors) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.userUpdate(
      email,
      name,
      surname,
      mobile,
    );
    if (res == null) {
      emit(UserPageState(error: 404));
    }
    if (res?.success ?? false) {
      emit(UserPageState(completed: true));
      return;
    } else {
      emit(UserPageState(error: 1));
    }

    return;
  }


  void cleanNameError() {
    emit(state.copyWith(nameError: 0, error: 0));
  }

  void cleanSurnameError() {
    emit(state.copyWith(surnameError: 0, error: 0));
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, error: 0));
  }

  void cleanPhoneError() {
    emit(state.copyWith(mobileError: 0, error: 0));
  }
}
