import 'package:up_api/features/login/data/repository/authentication_repository.dart';
import 'package:up_api/features/login/data/response/login_response.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';
import 'package:up_api/utils/service/service_locator.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<LoginResponse?> login(
    String email,
    String psw,
    bool rememberMe,
  ) async {
    final response = await upapiDatasource.post(
      'login',
      data: {'email': email, 'password': psw},
      baseUrlType: UpapiDatasourceBaseUrlType.publicUrl,
    );
    if (response != null &&
        (response.statusCode ?? 100) >= 200 &&
        (response.statusCode ?? 400) < 300) {
      LoginResponse? login;
      if (response.data is Map<String, dynamic>) {
        login = LoginResponse.fromJson(response.data as Map<String, dynamic>);
      }
      return login;
    }
    return null;
  }

  @override
  Future<String?> refreshToken() {
    /// TODO(): implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse?> register(
    String email,
    String psw,
    String name,
    String surname,
    String business,
  ) async {
    final response = await upapiDatasource.post(
      'signup',
      data: {
        'email': email,
        'password': psw,
        'firstName': name,
        'lastName': surname,
        'businessName': business,
      },
      baseUrlType: UpapiDatasourceBaseUrlType.publicUrl,
    );
    if (response != null &&
        (response.statusCode ?? 100) >= 200 &&
        (response.statusCode ?? 400) < 300) {
      LoginResponse? register;
      if (response.data is Map<String, dynamic>) {
        register = LoginResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      return register;
    }
    return null;
  }
}
