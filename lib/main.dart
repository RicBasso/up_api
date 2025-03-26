import 'package:flutter/material.dart';
import 'package:up_api/app.dart';
import 'package:up_api/flavor.dart';

void main(){
  upApiflavorConfig(FlavorType.develop);

  runApp(
      const MyApp(),
  );
}
