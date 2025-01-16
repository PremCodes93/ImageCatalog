import 'package:flutter_test/flutter_test.dart';
import 'package:image_listing_app/core/data/core_data.dart';
import 'package:image_listing_app/core/error/failures.dart';
import 'package:image_listing_app/features/listing/data/model/news_model.dart';
import 'package:image_listing_app/features/listing/data/repositories/image_listing_repository.dart';
import 'package:image_listing_app/features/listing/presentation/bloc/image_listing_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'listing_bloc_test.mocks.dart';

@GenerateMocks([ImageListingRepository])
void main() {
  late MockImageListingRepository mockRepository;
  late ImageListingCubit cubit;

  setUp(() {
    mockRepository = MockImageListingRepository();
    cubit = ImageListingCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  test('Initial state should be ImageListingState', () {
    expect(cubit.state, const ImageListingState());
  });

  blocTest<ImageListingCubit, ImageListingState>(
    'emits [Loading, ImageLoaded] when getImageList is successful',
    build: () {
      when(mockRepository.getImageList(1)).thenAnswer((_) async => DataResponse.success(NewsModel(
            data: [
              NewsData(uuid: 'uuId', imageUrl: 'https://example.com/image1.jpg'),
              NewsData(uuid: 'uuId', imageUrl: 'https://example.com/image2.jpg'),
            ],
            meta: Meta(limit: 2, returned: 2, found: 2, page: 2),
          )));
      return cubit;
    },
    act: (cubit) => cubit.getImageList(),
    expect: () => [
      ImageListingState.imageLoaded(
        ['https://example.com/image1.jpg', 'https://example.com/image2.jpg'],
        true,
      ),
    ],
    verify: (_) {
      verify(mockRepository.getImageList(1)).called(1);
    },
  );

  var serverFailure = const ServerFailure();
  blocTest<ImageListingCubit, ImageListingState>(
    'emits [Loading, Error, Reset] when getImageList fails',
    build: () {
      when(mockRepository.getImageList(1)).thenAnswer((_) async => DataResponse.failure(serverFailure));
      return cubit;
    },
    act: (cubit) => cubit.getImageList(),
    expect: () => [
      ImageListingState.error(serverFailure),
      const ImageListingState.reset(),
    ],
    verify: (_) {
      verify(mockRepository.getImageList(1)).called(1);
    },
  );

  blocTest<ImageListingCubit, ImageListingState>(
    'increments page and emits [Loading, ImageLoaded] when more images can be loaded',
    build: () {
      when(mockRepository.getImageList(1)).thenAnswer((_) async => DataResponse.success(NewsModel(
            data: [NewsData(uuid: 'uuId', imageUrl: 'https://example.com/image1.jpg')],
            meta: Meta(limit: 2, returned: 2, found: 2, page: 2),
          )));
      return cubit;
    },
    act: (cubit) => cubit.getImageList(),
    expect: () => [
      ImageListingState.imageLoaded(
        ['https://example.com/image1.jpg'],
        true,
      ),
    ],
    verify: (_) {
      verify(mockRepository.getImageList(1)).called(1);
      expect(cubit.page, 2);
    },
  );

  blocTest<ImageListingCubit, ImageListingState>(
    'does not increment page and emits [Loading, ImageLoaded] when no more images can be loaded',
    build: () {
      when(mockRepository.getImageList(1)).thenAnswer((_) async => DataResponse.success(NewsModel(
            data: [NewsData(uuid: 'uuId', imageUrl: 'https://example.com/image1.jpg')],
            meta: Meta(limit: 2, returned: 1, found: 2, page: 2),
          )));
      return cubit;
    },
    act: (cubit) => cubit.getImageList(),
    expect: () => [
      ImageListingState.imageLoaded(
        ['https://example.com/image1.jpg'],
        false,
      ),
    ],
    verify: (_) {
      verify(mockRepository.getImageList(1)).called(1);
      expect(cubit.page, 1);
    },
  );
}
