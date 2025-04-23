import 'package:up_api/features/welcome/bloc/welcome_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';



class WelcomeCubit extends BaseCubit<WelcomeState> {
  WelcomeCubit(super.initialState);

  void updatePercentage(double percentage){
    emit(state.copyWith(heightPercentage: percentage));
  }
}
