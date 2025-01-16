import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../injection/environment_config.dart';

@Injectable()
class ApiClientBase {
  final Dio dio;

  ApiClientBase(this.dio) {
    dio.options.receiveDataWhenStatusError = true;
    dio.options.connectTimeout = EnvironmentConfig.connectTimeout;
    dio.options.receiveTimeout = EnvironmentConfig.receiveTimeout;
  }

  Options _buildHeaders(String? token) {
    return Options(headers: token != null ? {"Authorization": "Bearer $token"} : null);
  }

  Future<Response<T>> get<T>(
    String route, {
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    try {
      final response = await dio.get<T>(
        route,
        queryParameters: queryParam,
        options: _buildHeaders(token),
      );
      return response;
    } on DioError catch (dioError) {
      debugPrint("DioError: ${dioError.message}");
      rethrow;
    } catch (err) {
      debugPrint("Unexpected error: $err");
      rethrow;
    }
  }
}
