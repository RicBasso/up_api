import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';

class TokenManager {
  String? _token;

  void saveTokens({
    String? token,
    String? refreshToken,
  }){
    this._token = token;
    sharedPrefs
    ..set(Constants.TOKEN_KEY, token ?? Constants.TOKEN_KEY)
    ..set(Constants.REFRESH_KEY, refreshToken ?? Constants.REFRESH_KEY);
  }

  String? getToken(){
    return _token ??= sharedPrefs.get(Constants.TOKEN_KEY);
  }

  String? get token => _token ??= sharedPrefs.get(Constants.TOKEN_KEY);

  String? getRefreshToken(){
    return sharedPrefs.get(Constants.REFRESH_KEY);
  }

  String? get refreshToken => sharedPrefs.get(Constants.REFRESH_KEY);

  void clear(){
    _token = null;
    sharedPrefs
      ..remove(Constants.TOKEN_KEY)
      ..remove(Constants.REFRESH_KEY);
  }
}


