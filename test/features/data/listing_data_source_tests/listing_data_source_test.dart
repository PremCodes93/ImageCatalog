import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_listing_app/core/error/exceptions.dart';
import 'package:image_listing_app/features/listing/data/datasources/image_listing_data_source.dart';
import 'package:image_listing_app/features/listing/data/model/news_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:image_listing_app/core/core_data_source.dart';

import 'listing_data_source_test.mocks.dart';

@GenerateMocks([ApiClientBase, CoreUtils])
void main() {
  late ImageListingDataSourceImpl dataSource;
  late MockApiClientBase mockApiClientBase;
  late MockCoreUtils mockCoreUtils;

  setUp(() {
    mockApiClientBase = MockApiClientBase();
    mockCoreUtils = MockCoreUtils();
    dataSource = ImageListingDataSourceImpl(mockApiClientBase, mockCoreUtils);
  });

  group('getImageList', () {
    const token = 'test_token';
    const page = 1;
    var requestOptions = RequestOptions(path: 'path');

    test('should return a NewsModel when the call is successful', () async {
      // Arrange
      final response = {
        "meta": {"found": 1207902, "returned": 10, "limit": 10, "page": 1},
        "data": [
          {
            "uuid": "13d7871a-a6c4-4399-b804-d9c9a03825b0",
            "image_url":
                "https://cdn.vox-cdn.com/thumbor/8v6WjKd-2Jy4WAtc7icwyKnaHQw=/0x0:8256x5504/1200x628/filters:focal(3738x1585:3739x1586)/cdn.vox-cdn.com/uploads/chorus_asset/file/25832480/1435350518.jpg",
          }
        ]
      };

      final newsModel = NewsModel.fromJson(response);
      when(mockCoreUtils.getAppBaseUrl()).thenAnswer((_) async => 'api.example.com');
      when(mockApiClientBase.get('api.example.com/v1/news/top',
              queryParam: {"api_token": "test_token", "locale": "us", "limit": 3, "page": 1}))
          .thenAnswer((_) async => Response(data: response, statusCode: 200, requestOptions: RequestOptions(path: '')));

      // Act
      final result = await dataSource.getImageList(token, page);

      // Assert
      expect(result.data[0].imageUrl, newsModel.data[0].imageUrl);
      verify(mockApiClientBase.get('api.example.com/v1/news/top',
          queryParam: {"api_token": "test_token", "locale": "us", "limit": 3, "page": 1}));
      verify(mockCoreUtils.getAppBaseUrl());
    });

    test('should throw InternalServerException when status code is 500', () async {
      // Arrange
      final error = DioError(
        type: DioErrorType.response,
        requestOptions: requestOptions,
        response: Response<dynamic>(statusCode: 500, requestOptions: requestOptions),
      );
      when(mockCoreUtils.getAppBaseUrl()).thenAnswer((_) async => 'api.example.com');
      when(mockApiClientBase.get('api.example.com/v1/news/top',
              queryParam: <String, dynamic>{"api_token": "test_token", "locale": "us", "limit": 3, "page": 1}))
          .thenThrow(error);

      // Act
      final result = dataSource.getImageList;

      // Assert
      expect(result.call(token, page), throwsA(isA<InternalServerException>()));
    });
  });
}
