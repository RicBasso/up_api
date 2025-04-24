import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/field_check.dart';

import 'package:up_api/utils/service/service_locator.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(super.initialState);

  Future<void> login(String email, String password) async {
    final emailTrimmed = email.trim();
    final emailError = validateEmail(emailTrimmed);
    final passError = validatePasswordLogin(password);

    final hasErrors = emailError + passError > 0;

    emit(state.copyWith(emailError: emailError, passError: passError));

    if (hasErrors) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.login(emailTrimmed, password);
    if (res == null) {
      emit(LoginState(error: 'GENERIC_ERROR'));
    }
    if (res?.success ?? false) {
      emit(state.copyWith(isLoading: false));
      final token = res?.loginBody?.accessToken;
      final refToken = res?.loginBody?.refreshToken;
      upapiTokenManager.saveTokens(token: token, refreshToken: refToken);
      upapiSessionManager.setUserSession(res?.loginBody?.user);
      upapiGoRouter.go(Routes.homepage);
    } else {
      emit(LoginState(error: res?.code));
    }
    return;
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, nullError: true));
  }

  void cleanPassError() {
    emit(state.copyWith(passError: 0, nullError: true));
  }
}
