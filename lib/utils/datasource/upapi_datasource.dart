import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:up_api/features/connection/cubit/connection_cubit.dart';
import 'package:up_api/flavor.dart';
import 'package:up_api/utils/datasource/datasource.dart';
import 'package:up_api/utils/interceptor/dio_interceptor.dart';
import 'package:up_api/utils/service/service_locator.dart';

enum UpapiDatasourceBaseUrlType { apiUrl, publicUrl }

class UpapiDatasource extends Datasource {


  UpapiDatasource() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: const Duration(seconds: 10000),
        receiveTimeout: const Duration(seconds: 30000),
        contentType: Headers.jsonContentType,
        //responseType: ResponseType.json,
      ),
    );
    _dio.interceptors.add(DioInterceptor(retry));
    _publicDio = Dio(
      BaseOptions(
        baseUrl: publicUrl,
        connectTimeout: const Duration(seconds: 10000),
        receiveTimeout: const Duration(seconds: 30000),
        contentType: Headers.jsonContentType,
        //responseType: ResponseType.json,
      ),
    );
    _publicDio.interceptors.add(DioInterceptor(retry));
  }


  Future<Response<dynamic>> retry(RequestOptions requestOptions)
  async{
    return _dio.fetch(requestOptions);
  }

  late final Dio _dio;
  late final Dio _publicDio;

/*
  Map<String, String> publicTokenHeader() {
    return {'Authorization': Constants.PUBLIC_API};
  }

  Map<String, String> privateTokenHeader() {
    return {'Authorization': upapiTokenManager.token ?? ''};
  }
*/

  /// Version of the app
  String? appVersion;

  Dio correctDio(UpapiDatasourceBaseUrlType baseUrlType) {
    return baseUrlType == UpapiDatasourceBaseUrlType.apiUrl ? _dio : _publicDio;
  }

  @override
  Future<Response?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers = const {},
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  }) async {
    //await upapiSessionManager.navigatorKey.currentContext!.read<ConnectionCubit>().refreshConnection();
    try {
      debugPrint('GET $baseUrlType/$path');
      final dio = correctDio(baseUrlType);
      final response = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      debugPrint('COMPLETE URL: ${response.realUri}');
      return response;
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.type}');
      if(e.type == DioExceptionType.connectionError){
          return Response(
            requestOptions: e.requestOptions,
            statusCode: 200,
            data: {
              'success': false,
              'code': 'CONNECTION_ERROR',
            },
          );
      }else{
        rethrow;
      }

    } catch (e) {
      debugPrint('GENERIC API ERROR: $e');
      return null;
    }
  }

  @override
  Future<Response?> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  }) async {
    //await upapiSessionManager.navigatorKey.currentContext!.read<ConnectionCubit>().refreshConnection();
    debugPrint('POST $path');
    try {
      final dio = correctDio(baseUrlType);
      final response = await dio.post<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      debugPrint('COMPLETE URL: ${response.realUri}');
      return response;
    } on DioException catch (e) {
      debugPrint('Dio error: $e');
      if(e.type == DioExceptionType.connectionError){
        return Response(
          requestOptions: e.requestOptions,
          statusCode: 200,
          data: {
            'success': false,
            'code': 'CONNECTION_ERROR',
          },
        );
      }else{
        rethrow;
      }
    } catch (e) {
      debugPrint('GENERIC API ERROR: $e');
      return null;
    }
  }

  @override
  Future<Response?> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  }) async {
    //await upapiSessionManager.navigatorKey.currentContext!.read<ConnectionCubit>().refreshConnection();
    debugPrint('PUT $path');
    debugPrint('data: $data');
    try {
      final dio = correctDio(baseUrlType);
      final response = await dio.put<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      debugPrint('COMPLETE URL: ${response.realUri}');
      return response;
    } on DioException catch (e) {
      debugPrint('Dio error: $e');
      if(e.type == DioExceptionType.connectionError){
        return Response(
          requestOptions: e.requestOptions,
          statusCode: 200,
          data: {
            'success': false,
            'code': 'CONNECTION_ERROR',
          },
        );
      }else{
        rethrow;
      }
    } catch (e) {
      debugPrint('GENERIC API ERROR: $e');
      return null;
    }
  }

  @override
  Future<Response?> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    UpapiDatasourceBaseUrlType baseUrlType = UpapiDatasourceBaseUrlType.apiUrl,
  }) async {
    //await upapiSessionManager.navigatorKey.currentContext!.read<ConnectionCubit>().refreshConnection();
    debugPrint('DELETE $path');
    try {
      final dio = correctDio(baseUrlType);
      final response = await dio.delete<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      debugPrint('COMPLETE URL: ${response.realUri}');
      return response;
    } on DioException catch (e) {
      debugPrint('Dio error: $e');
      if(e.type == DioExceptionType.connectionError){
        return Response(
          requestOptions: e.requestOptions,
          statusCode: 200,
          data: {
            'success': false,
            'code': 'CONNECTION_ERROR',
          },
        );
      }else{
        rethrow;
      }
    } catch (e) {
      debugPrint('GENERIC API ERROR: $e');
      return null;
    }
  }



  ///
  String get scheme => FlavorConfig.instance.scheme;

  ///
  String get domain => FlavorConfig.instance.domain;

  ///
  String get publicPath => FlavorConfig.instance.publicPath;

  String get apiPath => FlavorConfig.instance.apiPath;

  ///
  @override
  String get apiUrl => scheme + domain + apiPath;

  ///
  String get publicUrl => scheme + domain + publicPath;
}

