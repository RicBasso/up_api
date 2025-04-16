import 'package:dio/dio.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/service/service_locator.dart';

class DioInterceptor extends InterceptorsWrapper {
  DioInterceptor(this.retry);

  final Function retry;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final res = await upapiAuthentication.refreshToken();
      if(res){
        final newToken = upapiTokenManager.getToken();
        if (newToken != null) {
          try {
            err.requestOptions.headers['Authorization'] =
                newToken;
            handler.resolve(await retry(err.requestOptions) as Response);
          } on DioException catch (e) {
            handler.next(e);
          }
        }
      }
      return;
    }
    return super.onError(err, handler);
  }

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler,
      ) async {
    final Map<String,dynamic>headers;
    final token = upapiTokenManager.getToken();
    if (upapiDatasource.publicUrl == options.baseUrl){
      headers = {'Authorization': Constants.PUBLIC_API};
    }else{
      headers = {'Authorization': token};
    }
    options.headers.addAll(headers);
    return super.onRequest(options, handler);
  }



}
