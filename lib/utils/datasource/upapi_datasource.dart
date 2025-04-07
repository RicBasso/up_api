import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:up_api/flavor.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/datasource/datasource.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';

enum UpapiDatasourceBaseUrlType { apiUrl, publicUrl }

class UpapiDatasource extends Datasource {
  UpapiDatasource() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: const Duration(seconds: 10000),
        receiveTimeout: const Duration(seconds: 30000),
        headers: tokenAuth(),
        contentType: Headers.jsonContentType,
        //responseType: ResponseType.json,
      ),
    );

    _publicDio = Dio(
      BaseOptions(
        baseUrl: publicUrl,
        connectTimeout: const Duration(seconds: 10000),
        receiveTimeout: const Duration(seconds: 30000),
        headers: publicToken(),
        contentType: Headers.jsonContentType,
        //responseType: ResponseType.json,
      ),
    );
  }

  late final Dio _dio;
  late final Dio _publicDio;

  /// Token
  Map<String, String> tokenAuth() {
    return {'Authorization': upapiSessionManager.token ?? ''};
  }

  void logout() {
    upapiSessionManager.token = '';
  }

  String? getRefreshToken() {
    if (sharedPrefs.has(Constants.REFRESH_KEY)) {
      final refreshToken = sharedPrefs.get(Constants.REFRESH_KEY);
      return refreshToken;
    }
    return null;
  }

  Map<String, String> publicToken() {
    //giusto MAP?
    return {'Authorization': Constants.PUBLIC_API};
  }

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
    debugPrint('GET $baseUrlType/$path');
    try {
      final dio = correctDio(baseUrlType);
      final response = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      debugPrint('COMPLETE URL: ${response.realUri}');
      if (response.statusCode == 401 || response.statusCode == 403) {
        debugPrint('status code: ${response.statusCode}');

        ///await AuthenticationRepositoryImpl().refreshToken();
        return null;
        return get(
          path,
          queryParameters: queryParameters,

          ///baseUrlType: UpapiDatasourceBaseUrlType.apiUrl,
        );
      }

      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.unknown) {
        rethrow;
      } else if (e.type == DioErrorType.badResponse && e.response != null) {}
      return null;
    } catch (e) {
      rethrow;
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
      if (response.statusCode == 401 || response.statusCode == 403) {
        ///await AuthenticationRepositoryImpl().refreshToken();
        return post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,

          ///baseUrlType: UpapiDatasourceBaseUrlType.apiUrl,
        );
      }
      return response;
    } on DioError catch (e) {
      debugPrint('Dio error: $e');
      if (e.type == DioErrorType.unknown) {
        throw e.error!;
      }
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        ///AuthenticationRepositoryImpl().refreshToken();
        await post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          baseUrlType: baseUrlType,
        );
        throw UnauthorizedException();
      }
      return null;
    } catch (e) {
      rethrow;
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
      if (response.statusCode == 401 || response.statusCode == 403) {
        ///await AuthenticationRepositoryImpl().refreshToken();
        return post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
        );
      }
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.unknown) {
        throw e.error!;
      }
      if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
        ///AuthenticationRepositoryImpl().refreshToken();
        await post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          baseUrlType: baseUrlType,
        );
        throw UnauthorizedException();
      }
      return null;
    } catch (e) {
      rethrow;
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.unknown) {
        throw e.error!;
      }
      if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
        ///AuthenticationRepositoryImpl().refreshToken();
        await delete(
          path,
          baseUrlType: baseUrlType,
          queryParameters: queryParameters,
          data: data,
          options: options,
        );

        throw UnauthorizedException();
      }
      return null;
    } catch (e) {
      rethrow;
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
  String get apiUrl => scheme + domain + apiPath;

  ///
  String get publicUrl => scheme + domain + publicPath;
}

class UnauthorizedException implements Exception {
  UnauthorizedException([this.message]);

  final dynamic message;

  @override
  String toString() {
    final Object? message = this.message;
    if (message == null) return 'Unauthorized';
    return 'Unauthorized: $message';
  }
}
