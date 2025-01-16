import 'package:image_listing_app/features/listing/data/repositories/image_listing_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_listing_bloc.freezed.dart';

@Freezed()
class ImageListingState with _$ImageListingState {
  const factory ImageListingState() = Initial;
  const factory ImageListingState.loading() = Loading;
  const factory ImageListingState.imageLoaded(List<String> urlList, bool loadMore) = ImageLoaded;
  const factory ImageListingState.reset() = Reset;
  const factory ImageListingState.error(Failure? failure) = Error;
}

@Injectable()
class ImageListingCubit extends Cubit<ImageListingState> {
  final ImageListingRepository _repository;

  ImageListingCubit(this._repository) : super(const ImageListingState());

  int page = 1;

  Future getImageList() async {
    var result = await _repository.getImageList(page);
    if (result.isSuccessful) {

      List<String> urlList = result.content?.data.map((news) => news.imageUrl).toList() ?? [];
      bool loadMore = (result.content?.meta.limit ?? 0) == (result.content?.meta.returned ?? 0);
      if (loadMore) {
        page++;
      }
      emit(ImageListingState.imageLoaded(urlList, loadMore));
    } else {
      emit(ImageListingState.error(result.failure));
      emit(ImageListingState.reset());
    }
  }
}
