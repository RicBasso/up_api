import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/features/register/bloc/register_state.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit(super.initialState);

  Future<void> register(
    String email,
    String password,
    String name,
    String surname,
    String business,
  ) async {
    final emailError = validateEmail(email);
    final passError = validatePassword(password);
    final nameError = validateName(name);

    final surnameError = validateName(surname);
    final businessError = validateBusiness(business);

    final hasErrors =
        emailError + passError + nameError + surnameError + businessError > 0;
    emit(
      state.copyWith(
        emailError: emailError,
        passError: passError,
        nameError: nameError,
        surnameError: surnameError,
        businessError: businessError,
      ),
    );
    if (hasErrors) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.register(
      email,
      password,
      name,
      surname,
      business,
    );
    if (res == null) {
      emit(RegisterState(error: 404));
    }
    if (res?.success ?? false) {
      emit(state.copyWith(isLoading: false));
      final token = res?.loginBody?.accessToken;
      final refToken = res?.loginBody?.refreshToken;
      upapiSessionManager.token = token;
      sharedPrefs.set(Constants.REFRESH_KEY, refToken ?? '');

      upapiSessionManager.user = res?.loginBody?.user;
      upapiGoRouter.go(Routes.homepage);
      return;
    } else {
      emit(RegisterState(error: 1));
    }

    return;
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, error: 0));
  }

  void cleanPassError() {
    emit(state.copyWith(passError: 0, error: 0));
  }

  void cleanNameError() {
    emit(state.copyWith(nameError: 0, error: 0));
  }

  void cleanSurnameError() {
    emit(state.copyWith(surnameError: 0, error: 0));
  }

  void cleanBusinessError() {
    emit(state.copyWith(businessError: 0, error: 0));
  }
}
