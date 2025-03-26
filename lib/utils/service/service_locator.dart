import 'package:get_it/get_it.dart';
import 'package:up_api/utils/datasource/datasource.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';

final GetIt getIt = GetIt.instance;

void registerDependencies(){
  getIt.registerSingleton<Datasource>(UpapiDatasource());
}

Datasource get upapiDatasource => getIt.get<Datasource>();
