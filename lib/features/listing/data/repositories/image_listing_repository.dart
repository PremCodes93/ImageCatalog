import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_listing_app/features/listing/data/datasources/image_listing_data_source.dart';
import 'package:image_listing_app/features/listing/data/model/news_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/core_data.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

abstract class ImageListingRepository {
  Future<DataResponse<NewsModel>> getImageList(int page);
}


@Injectable(as: ImageListingRepository)
class ImageListingRepositoryImpl extends ImageListingRepository {
  final ImageListingDataSource _dataSource;
  final FlutterSecureStorage _secureStorage;
  final NetworkInfo _networkInfo;

  ImageListingRepositoryImpl(this._dataSource, this._secureStorage, this._networkInfo);

  @override
  Future<DataResponse<NewsModel>> getImageList(int page) async {
    bool hasNetwork = await _networkInfo.isConnected;
    if (hasNetwork) {
      try {
        var token = await _secureStorage.read(key: CoreConstants.accessToken);
        var result = await _dataSource.getImageList(token!, page);
        return DataResponse.success(result);
      } catch (err) {
        return const DataResponse.failure(ServerFailure());
      }
    } else {
      return const DataResponse.failure(NoInternetFailure());
    }
  }
}

