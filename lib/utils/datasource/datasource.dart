import 'package:dio/dio.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';

abstract class Datasource {
  Future<Response?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers = const {},
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  });

  Future<Response?> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  });

  Future<Response?> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  });

  Future<Response?> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  });
}
