// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../../features/listing/data/datasources/image_listing_data_source.dart'
    as _i40;
import '../../features/listing/data/repositories/image_listing_repository.dart'
    as _i1062;
import '../../features/listing/presentation/bloc/image_listing_bloc.dart'
    as _i84;
import '../api_client/api_client.dart' as _i274;
import '../core_data_source.dart' as _i715;
import '../data/core_utils.dart' as _i1031;
import '../network/network_info.dart' as _i932;
import 'dio_injection.dart' as _i373;
import 'network_connection_injection.dart' as _i618;
import 'secure_storage_injection.dart' as _i109;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioInjection = _$DioInjection();
  final secureStorageInjection = _$SecureStorageInjection();
  final internetConnectionInjection = _$InternetConnectionInjection();
  gh.factory<_i361.Dio>(() => dioInjection.dio);
  gh.factory<_i558.FlutterSecureStorage>(
      () => secureStorageInjection.secureStorage);
  gh.factory<_i973.InternetConnectionChecker>(
      () => internetConnectionInjection.networkInfo);
  gh.factory<_i274.ApiClientBase>(() => _i274.ApiClientBase(gh<_i361.Dio>()));
  gh.factory<_i1031.CoreUtils>(
      () => _i1031.CoreUtils(gh<_i558.FlutterSecureStorage>()));
  gh.factory<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
  gh.factory<_i40.ImageListingDataSource>(() => _i40.ImageListingDataSourceImpl(
        gh<_i715.ApiClientBase>(),
        gh<_i715.CoreUtils>(),
      ));
  gh.factory<_i1062.ImageListingRepository>(
      () => _i1062.ImageListingRepositoryImpl(
            gh<_i40.ImageListingDataSource>(),
            gh<_i558.FlutterSecureStorage>(),
            gh<_i932.NetworkInfo>(),
          ));
  gh.factory<_i84.ImageListingCubit>(
      () => _i84.ImageListingCubit(gh<_i1062.ImageListingRepository>()));
  return getIt;
}

class _$DioInjection extends _i373.DioInjection {}

class _$SecureStorageInjection extends _i109.SecureStorageInjection {}

class _$InternetConnectionInjection extends _i618.InternetConnectionInjection {}
