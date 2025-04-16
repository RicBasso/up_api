import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_api/utils/base_bloc/base_state/base_state.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);

  void showLoader() {
    debugPrint('inizio loading');
  }

  void hideLoader() {
    debugPrint('fine loading');
  }

  Future<T?> showAlert<T>(Widget child, bool barrierDismissible) async {
    return null;
  }
}
