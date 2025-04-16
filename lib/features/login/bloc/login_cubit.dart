import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(super.initialState);

  Future<void> login(
    String email,
    String password,
    String emailError,
    String passError,
    String genError,
  ) async {
    if (email.isEmpty) {
      emit(state.copyWith(emailError: emailError));
    }
    if (password.isEmpty) {
      emit(state.copyWith(passError: passError));
    }
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.login(email, password, false);
    if (res == null) {
      emit(state.copyWith(error: genError));
    }
    if (res?.success ?? false) {
      emit(state.copyWith(isLoading: false));
      final token = res?.loginBody?.accessToken;
      final refToken = res?.loginBody?.refreshToken;
      upapiTokenManager.saveTokens(token: token, refreshToken: refToken);
      upapiSessionManager.setUserSession(res?.loginBody?.user);
      upapiGoRouter.go(Routes.homepage);
      return;
    }
    emit(LoginState(error: genError));

    return;
  }

  void cleanEmailError() {
    emit(state.copyWith(nullEmail: true, nullError: true));
  }

  void cleanPassError() {
    emit(state.copyWith(nullPass: true, nullError: true));
  }
}
