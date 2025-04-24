import 'package:up_api/features/register/bloc/register_state.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit(super.initialState);

  Future<void> register(String email, String password, String name, String surname, String business) async {
    final emailTrimmed = email.trim();
    final nameTrimmed = name.trim();
    final surnameTrimmed = surname.trim();
    final businessTrimmed = business.trim();
    final emailError = validateEmail(emailTrimmed);
    final passError = validatePassword(password);
    final nameError = validateName(nameTrimmed);
    final surnameError = validateName(surnameTrimmed);
    final businessError = validateBusiness(businessTrimmed);


    final hasErrors = emailError + passError + nameError + surnameError + businessError > 0;
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
    final res = await upapiAuthentication.register(emailTrimmed, password, nameTrimmed, surnameTrimmed, businessTrimmed);
    if (res == null) {
      emit(RegisterState(error: 'GENERIC_ERROR'));
    }
    if (res?.success ?? false) {
      emit(state.copyWith(isLoading: false));
      final token = res?.loginBody?.accessToken;
      final refToken = res?.loginBody?.refreshToken;
      upapiTokenManager.saveTokens(token: token, refreshToken: refToken);
      upapiSessionManager.setUserSession(res?.loginBody?.user);
      upapiGoRouter.go(Routes.homepage);
      return;
    } else {
      emit(RegisterState(error: res?.code));
    }

    return;
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, nullError: true));
  }

  void cleanPassError() {
    emit(state.copyWith(passError: 0, nullError: true));
  }

  void cleanNameError() {
    emit(state.copyWith(nameError: 0, nullError: true));
  }

  void cleanSurnameError() {
    emit(state.copyWith(surnameError: 0, nullError: true));
  }

  void cleanBusinessError() {
    emit(state.copyWith(businessError: 0, nullError: true));
  }
}
