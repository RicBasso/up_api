import 'package:flutter/cupertino.dart';
import 'package:up_api/features/login/data/model/user.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/service/service_locator.dart';

class SessionManager<T> {
  User? user;
  GlobalKey? keyWelcome;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<T?>? modalBottomSheet;
  AnimationController? animation;

  void setUserSession(User? user) {
    this.user = user;
    sharedPrefs.set(Constants.USERID_KEY, user?.id ?? '');
  }

  void clear() {
    user = null;
    sharedPrefs.remove(Constants.USERID_KEY);
  }

  String? get userID => /*user?.id ?? */ sharedPrefs.get(Constants.USERID_KEY);
}
