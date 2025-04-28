import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:up_api/features/theme_mode_switcher/bloc/theme_mode_switcher_state.dart';
import 'package:up_api/utils/base_bloc/base_state/base_bloc.dart';
import 'package:up_api/utils/service/service_locator.dart';


class ThemeModeSwitcherCubit extends BaseCubit<ThemeModeSwitcherState> {

 ThemeModeSwitcherCubit(super.initialState) {
    init();
  }

 void init() {
   bool onDark;
   if (sharedPrefs.has('DARK_MODE')) {
     onDark = sharedPrefs.get('DARK_MODE') == 'true';
   } else {
     final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
     onDark = brightness == Brightness.dark;
   }
   emit(ThemeModeSwitcherState(onDark: onDark));
 }

 bool get onDark => state.onDark;


  void switchMode() {
    emit(state.copyWith(onDark: !state.onDark));
    sharedPrefs.set('DARK_MODE', state.onDark ? 'true' : 'false');
  }

}
