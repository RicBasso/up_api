import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/features/lost_password/bloc/lost_password_state.dart';
import 'package:up_api/features/lost_password/presentation/widgets/modal_lost_password_confirm.dart';
import 'package:up_api/features/register/bloc/register_state.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';
import 'package:up_api/utils/show_modal_handler.dart';

class LostPasswordCubit extends BaseCubit<LostPasswordState> {
  LostPasswordCubit(super.initialState);

  Future<bool> lostPassword(
      String email,
      ) async {
    final emailError = validateEmail(email);

    final hasErrors =
        emailError  > 0;
    emit(
      state.copyWith(
        emailError: emailError,
      ),
    );
    if (hasErrors) {
      return false;
    }
    emit(state.copyWith(isLoading: true));
    final res = await upapiAuthentication.lostPassword(
      email,
    );
    if (res == null) {
      emit(LostPasswordState(error: 404));
    }
    if (res?.success ?? false) {
      return true;
    } else {
      if(res?.code == 'USER_NOT_FOUND'){
        emit(LostPasswordState(error: 1));
        return false;
      }
      emit(LostPasswordState(error: 404));
    }

    return false;
  }

  void cleanEmailError() {
    emit(state.copyWith(emailError: 0, error: 0));
  }

}
