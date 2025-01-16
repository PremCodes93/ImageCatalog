import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'core_constants.dart';

@Injectable()
class CoreUtils {
  final FlutterSecureStorage _secureStorage;

  CoreUtils(this._secureStorage);

  Future<String> getAppBaseUrl() async {
    var baseUrl = await _secureStorage.read(key: CoreConstants.baseUrl);
    return 'https://$baseUrl';
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: CoreConstants.accessToken);
  }
}
