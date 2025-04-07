import 'package:up_api/features/login/data/response/login_response.dart';

abstract class AuthenticationRepository {
  Future<String?> refreshToken();
  Future<LoginResponse?> login(String email, String psw, bool rememberMe);
  Future<LoginResponse?> register(
    String email,
    String psw,
    String name,
    String surname,
    String business,
  );
}
