import 'package:up_api/features/init/response/get_user_response.dart';
import 'package:up_api/features/login/data/repository/authentication_repository.dart';
import 'package:up_api/features/login/data/response/login_response.dart';
import 'package:up_api/features/login/data/response/refresh_token_response.dart';
import 'package:up_api/features/lost_password/data/lost_password_response.dart';
import 'package:up_api/features/user/data/response/update_user_response.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/datasource/upapi_datasource.dart';
import 'package:up_api/utils/service/service_locator.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<LoginResponse?> login(String email, String psw) async {
    final response = await upapiDatasource.post(
      'login',
      data: {'email': email, 'password': psw},
      baseUrlType: UpapiDatasourceBaseUrlType.publicUrl,
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      LoginResponse? login;
      if (response.data != null) {
        login = LoginResponse.fromJson(response.data!);
      }
      return login;
    }
    return null;
  }

  @override
  Future<GetUserResponse?> getUserInfo(String? id) async {
    final response = await upapiDatasource.get('users/$id');

    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      GetUserResponse? info;
      if (response.data != null) {
        info = GetUserResponse.fromJson(response.data!);
      }

      return info;
    }
    return null;
  }

  @override
  Future<bool> refreshToken() async {
    final refresh = upapiTokenManager.getRefreshToken();
    final userId = upapiSessionManager.userID;
    final response = await upapiDatasource.post(
      'refresh',
      data: {'refreshToken': refresh, 'userId': userId},
      baseUrlType: UpapiDatasourceBaseUrlType.publicUrl,
      //options: Options(headers: {"Authorization": Constants.PUBLIC_API})
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      RefreshTokenResponse? responseRefresh;
      if (response.data != null) {
        responseRefresh = RefreshTokenResponse.fromJson(response.data!);
        if (responseRefresh.success && responseRefresh.token != null) {
          upapiTokenManager.saveTokens(token: responseRefresh.token);
          return true;
        }
      }
    }
    return false;
  }

  @override
  Future<LoginResponse?> register(String email, String psw, String name, String surname, String business) async {
    final response = await upapiDatasource.post(
      'signup',
      data: {'email': email, 'password': psw, 'firstName': name, 'lastName': surname, 'businessName': business},
      baseUrlType: UpapiDatasourceBaseUrlType.publicUrl,
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      LoginResponse? register;
      if (response.data != null) {
        register = LoginResponse.fromJson(response.data!);
      }
      return register;
    }
    return null;
  }

  @override
  Future<LostPasswordResponse?> lostPassword(String email) async {
    final response = await upapiDatasource.post(
      'recover',
      data: {'email': email},
      baseUrlType: UpapiDatasourceBaseUrlType.publicUrl,
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      if (response.data != null) {
        return LostPasswordResponse.fromJson(response.data!);
      }
    }
    return null;
  }

  @override
  Future<UpdateUserResponse?> userUpdate(String name, String surname, String email, String phone) async {
    final response = await upapiDatasource.put(
      'users/${upapiSessionManager.userID}',
      data: {'firstName': name, 'lastName': surname, 'email': email, 'phone': phone},
    );
    if (response != null && (response.statusCode ?? 100) >= 200 && (response.statusCode ?? 400) < 300) {
      if (response.data != null) {
        return UpdateUserResponse.fromJson(response.data!);
      }
    }
    return null;
  }

  @override
  void logout() {
    upapiSessionManager.clear();
    upapiTokenManager.clear();
    upapiGoRouter.go(Routes.welcome);
  }
}
