import 'package:flutter/material.dart';

class Constants {
  static String dmSans = 'DM Sans';
  static final GlobalKey BOTTOM_NAVIGATION_KEY = GlobalKey();
  static final GlobalKey HOME_NAVIGATION_KEY = GlobalKey();
  static var KEYS = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  static const String PUBLIC_API = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiSUdTb2x1dGlvbnMiLCJzdXJuYW1lIjoiSUdTb2x1dGlvbnMiLCJpZCI6LTIyMTU3Mzk0OTMsImp0aSI6ImJiZDBjZWUxLWRiNzMtNGZlMC1iM2EwLTI0Y2UzNWJjNTJmNCIsImlhdCI6MTU4NTMwOTUwOSwiZXhwIjo0MDc4MzAyODA4fQ.QdG2G7GizuuNHdChAtjPah4lmasyDlMOvo2fmUFZKGg';

  static const String TOKEN_KEY = 'token';
  static const String REFRESH_KEY = 'refresh_key';
  static const String USERID_KEY = 'userid_key';
  static const String USERNAME = 'username';

  static const String terms = 'https://';
  static const String ONESIGNAL_APP_ID = '';

  static const String LANGUAGE = 'language';

}
