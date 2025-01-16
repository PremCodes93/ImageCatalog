
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_listing_app/core/data/core_constants.dart';
import 'package:image_listing_app/core/data/core_utils.dart';
import 'package:image_listing_app/core/data/data_response.dart';
import 'package:image_listing_app/core/error/exceptions.dart';
import 'package:image_listing_app/core/error/failures.dart';
import 'package:image_listing_app/core/network/network_info.dart';
import 'package:image_listing_app/features/listing/data/datasources/image_listing_data_source.dart';
import 'package:image_listing_app/features/listing/data/model/news_model.dart';
import 'package:image_listing_app/features/listing/data/repositories/image_listing_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listing_repository_test.mocks.dart';

@GenerateMocks([ImageListingDataSource, FlutterSecureStorage, NetworkInfo, CoreUtils])
Future<void> main() async {
  late MockImageListingDataSource dataSource;
  late MockFlutterSecureStorage securedStorage;
  late MockNetworkInfo networkInfo;
  late ImageListingRepositoryImpl repository;
  late MockCoreUtils coreUtils;
  const String token = 'token';
  const String baseUrl = 'baseUrl';

  setUpAll(() {
    dataSource = MockImageListingDataSource();
    securedStorage = MockFlutterSecureStorage();
    networkInfo = MockNetworkInfo();
    coreUtils = MockCoreUtils();
    repository = ImageListingRepositoryImpl(dataSource, securedStorage,networkInfo);
  });
  setUp(() {
    when(securedStorage.read(key: CoreConstants.accessToken)).thenAnswer((_) async => token);
    when(securedStorage.read(key: CoreConstants.baseUrl)).thenAnswer((_) async => baseUrl);
  });

  group('ImageListing repository tests', () {
    test('imageListing returns a Server failure when there if something goes wrong in api call', () async {
      //arrange
      when(dataSource.getImageList(any, any)).thenThrow((_) async => const InternalServerException());
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      //act
      final result = await repository.getImageList(1);

      //assert
      expect(result.failure, const ServerFailure());
      verify(dataSource.getImageList(any, any));
    });
    test('imageListing returns a No-network failure when there is no network connection in device', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => false);
      //act
      final result = await repository.getImageList(1);
      //assert
      expect(result.failure, const NoInternetFailure());
      verify(networkInfo.isConnected);
    });

    test('login returns a DataResponse<String>', () async {
      //arrange
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
      when(dataSource.getImageList(any, any)).thenAnswer((_) async => newsModel);
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      //act
      final result = await repository.getImageList(1);
      //assert
      expect(result, isA<DataResponse<NewsModel>>());
      verify(dataSource.getImageList(any,any));
    });
  });

}