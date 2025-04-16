import 'package:flutter/cupertino.dart';
import 'package:up_api/features/login/data/model/user.dart';
import 'package:up_api/utils/constants.dart';
import 'package:up_api/utils/service/service_locator.dart';

class SessionManager {
  User? user;
  GlobalKey? keyWelcome;

  void setUserSession(User? user){
    this.user = user;
    sharedPrefs.set(Constants.USERID_KEY, user?.id ?? '');

  }

  String? get userID => /*user?.id ?? */sharedPrefs.get(Constants.USERID_KEY);
  }
