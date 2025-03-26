import 'package:up_api/features/login/bloc/login_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';

class LoginCubit extends BaseCubit<LoginState>{
  LoginCubit(super.initialState);

  //LoginCubit(super.initialState);
//prendermi email e pass creare funzione login(), sviluppare errore

  void login(String email, String password, String emailError, String passError){
    if(email.isEmpty){
      emit(state.copyWith(emailError: emailError));
    }
    if(password.isEmpty){
      emit(state.copyWith(passError: passError));
    }
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    emit(LoginState());
    return;
  }

  void cleanEmailError(){
    emit(state.copyWith(nullEmail:true));
  }

  void cleanPassError(){
    emit(state.copyWith(nullPass:true));
  }

}
