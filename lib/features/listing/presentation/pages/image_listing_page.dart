import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_listing_app/features/listing/presentation/bloc/image_listing_bloc.dart';
import 'package:image_listing_app/features/listing/presentation/widgets/image_utils.dart';
import 'package:image_listing_app/presentation/widgets/loading/app_loading_widget.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/injection/injection.dart';
import '../widgets/image_grid_builder.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageListingCubit>(
      create: (context) => locator<ImageListingCubit>(),
      child: const _ListingView(),
    );
  }
}

class _ListingView extends StatefulWidget {
  const _ListingView({super.key});

  @override
  State<_ListingView> createState() => _ListingViewState();
}

class _ListingViewState extends State<_ListingView> {
  final _listingController = ScrollController();
  bool hasMoreData = true;
  List<String> urlList = [];

  @override
  void initState() {
    _dispatchLoadImages(context);
    _listingController.addListener(() {
      if (_listingController.position.maxScrollExtent == _listingController.offset) {
        if (hasMoreData) {
          _dispatchLoadImages(context);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _listingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ImageListingCubit, ImageListingState>(
      listener: (context, state) {
        state.when(
          () {},
          loading: () {},
          reset: () {},
          imageLoaded: (newList, canLoadMore) {
            hasMoreData = canLoadMore;
            urlList.addAll(newList);
          },
          error: (err) {
            _processFailure(context, err);
          },
        );
      },
      child: BlocBuilder<ImageListingCubit, ImageListingState>(builder: (context, state) {
        if (state is Initial) {
          return Center(child: AppLoader());
        }
        return ImageGridBuilder(
          urlList: urlList,
          controller: _listingController,
        );
      }),
    ));
  }
}

Future<void> _dispatchLoadImages(BuildContext context) async {
  context.read<ImageListingCubit>().getImageList();
}

void _processFailure(BuildContext context, Failure? failure) async {
  String errorMsg;
  if (failure is NoInternetFailure) {
    ImageUtils.showErrorMsg(context);
  } else {}
}
