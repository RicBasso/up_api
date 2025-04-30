import 'package:up_api/features/add_monitor/bloc/add_monitor_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/field_check.dart';
import 'package:up_api/utils/service/service_locator.dart';

class AddMonitorCubit extends BaseCubit<AddMonitorState> {
  AddMonitorCubit(super.initialState);

  Future<void> saveChanges(String name,) async {
    /*final nameTrimmed = name.trim();
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
      emit(AddMonitorState(error: 'GENERIC_ERROR'));
    }
    if (res?.success ?? false) {
      upapiSessionManager.user = res?.user;
      emit(AddMonitorState(completed: true));
      return;
    } else {
      emit(AddMonitorState(error: res?.code));
    }
*/
    return;
  }

  void cleanNameError() {
    emit(state.copyWith(nameError: 0, nullError: true, completed: false));
  }



}
