import 'package:up_api/features/init/response/get_user_response.dart';
import 'package:up_api/features/login/data/response/login_response.dart';
import 'package:up_api/features/lost_password/data/lost_password_response.dart';

abstract class AuthenticationRepository {
  Future<bool> refreshToken();
  Future<LoginResponse?> login(String email, String psw);
  Future<LoginResponse?> register(
    String email,
    String psw,
    String name,
    String surname,
    String business,
  );
  Future<LostPasswordResponse?> lostPassword(String email);
  Future<GetUserResponse?> getUserInfo(String? id);
  void logout();
}
