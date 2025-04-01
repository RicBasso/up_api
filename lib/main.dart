import 'package:flutter/material.dart';
import 'package:up_api/app.dart';
import 'package:up_api/flavor.dart';
import 'package:up_api/routes/create_go_router.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/shared_prefs.dart';

final _router = createGoRouter();

void main() {
  upApiFlavorConfig(FlavorType.develop);
  // GoRouter configuration

  registerDependencies(_router);
  sharedPrefs.init();
  runApp(const MyApp());
}
