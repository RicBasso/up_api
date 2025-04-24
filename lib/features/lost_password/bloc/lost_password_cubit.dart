import 'package:up_api/features/lost_password/bloc/lost_password_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';

class LostPasswordCubit extends BaseCubit<LostPasswordState> {
  LostPasswordCubit(super.initialState);

  Future<bool> lostPassword(String email) async {
    final emailTrimmed = email.trim();
    final emailError = validateEmail(emailTrimmed);

    final hasErrors = emailError > 0;
    emit(state.copyWith(emailError: emailError));
    if (hasErrors) {
      return false;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.lostPassword(emailTrimmed);
    if (res == null) {
      emit(LostPasswordState(error: 'GENERIC_ERROR'));
    }
    if (res?.success ?? false) {
      return true;
    } else {
      emit(LostPasswordState(error: res?.code));
    }

    return false;
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, nullError: true));
  }
}
