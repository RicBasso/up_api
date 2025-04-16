import 'package:flutter_flavor/flutter_flavor.dart';

enum FlavorType { develop, test, production }

FlavorConfig upApiFlavorConfig(FlavorType flavor) {
  switch (flavor) {
    case FlavorType.develop:
      return FlavorConfig(
        name: 'DEVELOP',
        variables: {
          FlavorConstants.scheme: 'http://',
          'domain': 'vps-1a54a8e7.vps.ovh.net:7595',
          'apiPath': '/api/',
          'publicPath': '/public-api/',
        },
      );

    case FlavorType.test:
      return FlavorConfig(
        name: 'TEST',
        variables: {
          FlavorConstants.scheme: 'http://',
          'domain': 'vps-1a54a8e7.vps.ovh.net:7595',
          'apiPath': '/api/',
          'publicPath': '/public-api/',
        },
      );

    case FlavorType.production:
      return FlavorConfig(
        name: 'TEST',
        variables: {
          FlavorConstants.scheme: 'http://',
          'domain': 'vps-1a54a8e7.vps.ovh.net:7595',
          'apiPath': '/api/',
          'publicPath': '/public-api/',
        },
      );
  }
}

class FlavorConstants {
  static String scheme = 'scheme';
  static String domain = 'domain';
  static String apiPath = 'apiPath';
  static String publicPath = 'publicPath';
}

extension FlavorConfigExt on FlavorConfig {
  String get scheme =>
      FlavorConfig.instance.variables[FlavorConstants.scheme] as String;
  String get domain =>
      FlavorConfig.instance.variables[FlavorConstants.domain] as String;
  String get apiPath =>
      FlavorConfig.instance.variables[FlavorConstants.apiPath] as String;
  String get publicPath =>
      FlavorConfig.instance.variables[FlavorConstants.publicPath] as String;
}
