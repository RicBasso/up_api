import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/app_preferences_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/service/service_locator.dart';


class AppPreferencesCubit extends BaseCubit<AppPreferencesState> {

 AppPreferencesCubit(super.initialState) {
    init();
  }

 void init() {
   String languageCode;
   bool onDark;
   if (sharedPrefs.has('LOCALE')) {
     languageCode = sharedPrefs.get('LOCALE');
   }else{
     final locale = PlatformDispatcher.instance.locale;
     languageCode = locale.languageCode;
   }
   if (sharedPrefs.has('DARK_MODE')) {
     onDark = sharedPrefs.get('DARK_MODE') == 'true';
   } else {
     final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
     onDark = brightness == Brightness.dark;
   }
   emit(AppPreferencesState(location: languageCode, onDark: onDark));
 }

  void switchThemeMode() {
   emit(state.copyWith(onDark: !state.onDark));
   sharedPrefs.set('DARK_MODE', state.onDark ? 'true' : 'false');
  }

  void switchLanguage(String languageCode) {
    emit(state.copyWith(location: languageCode));
    sharedPrefs.set('LOCALE', languageCode);
  }


 bool get onDark => state.onDark;
 String get language => state.location;

}
