import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../presentation/data/presentation_constants.dart';
import '../data/core_constants.dart';

class EnvironmentConfig {
  static const int connectTimeout = 40000;
  static const int receiveTimeout = 40000;
}

enum DomainType { prod, demo, staging }

class ConfigureEnvironment {
  static Future<void> configureEndpoints() async {
    const baseUrlConfig = String.fromEnvironment(ConfigKeys.baseUrlConfig);
    const tokenConfig = String.fromEnvironment(ConfigKeys.tokenConfig);
    await const FlutterSecureStorage().write(key: CoreConstants.baseUrl, value: baseUrlConfig);
    await const FlutterSecureStorage().write(key: CoreConstants.accessToken, value: tokenConfig);
  }
}
