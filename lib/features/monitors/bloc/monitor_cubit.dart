import 'package:dio/dio.dart';
import 'package:up_api/features/home/bloc/home_state.dart';
import 'package:up_api/features/home/data/repository/projects_repository_impl.dart';
import 'package:up_api/features/home/data/response/projects_response.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';
import 'package:up_api/utils/service/service_locator.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(super.initialState);

  Future<void> getMonitors() async {
    final response = await upapiProjectsRepository.getProjectsResponse();
    //state.projects = response?.projectsBody;
  }
}
