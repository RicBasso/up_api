import 'package:up_api/features/home/bloc/home_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/service/service_locator.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(super.initialState);

  Future<void> getProjects() async {
    final response = await upapiProjectsRepository.getProjectsResponse();
      emit(state.copyWith(
        projects: response?.projectsBody,
      ),
    );
  }
}

