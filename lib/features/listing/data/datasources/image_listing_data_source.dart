import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../model/news_model.dart';

abstract class ImageListingDataSource {
  Future<NewsModel> getImageList(String token, int page);
}

@Injectable(as: ImageListingDataSource)
class ImageListingDataSourceImpl extends ImageListingDataSource {
  final ApiClientBase _apiClientBase;
  final CoreUtils _utils;

  ImageListingDataSourceImpl(this._apiClientBase, this._utils);

  @override
  Future<NewsModel> getImageList(String token, int page) async {
    try {
      String baseUrl = await _utils.getAppBaseUrl();
      String path = '$baseUrl${CoreConstants.newsApi}';
      debugPrint('Path - : $path');
      var queryParam = {"api_token": token, "locale": "us", "limit": 3, "page": page};
      var response = await _apiClientBase.get(path, queryParam: queryParam);
      debugPrint('$response');
      return NewsModel.fromJson(response.data);
    } on DioError catch (err) {
      debugPrint('err : $err');
      _processFailure(err.response);
      rethrow;
    }
  }
}

T _processFailure<T>(Response<dynamic>? response) {
  switch (response?.statusCode) {
    default:
      throw const InternalServerException();
  }
}
