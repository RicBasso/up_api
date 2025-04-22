import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:up_api/app.dart';
import 'package:up_api/flavor.dart';
import 'package:up_api/routes/create_go_router.dart';
import 'package:up_api/routes/routes.dart';
import 'package:up_api/utils/service/service_locator.dart';

Future<void> main()  async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  upApiFlavorConfig(FlavorType.develop);
  await registerDependencies();
  final initialPage = await _init();
  registerRouter(createGoRouter(initialPage));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future<String> _init() async {
  var initialPage = Routes.welcome;
  final token = upapiTokenManager.token;
  final id = upapiSessionManager.userID;
  final result = await Connectivity().checkConnectivity();
  if(result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)){
    if(token != null && token != '' && id != null && id != ''){
      final res = await upapiAuthentication.getUserInfo(id);
      if(res != null && res.success){
        upapiSessionManager.setUserSession(res.user);
        initialPage = Routes.homepage;
      }
    }
  }

  return initialPage;
}
