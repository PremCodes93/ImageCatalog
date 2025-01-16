import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_listing_app/core/error/failures.dart';
import 'package:image_listing_app/features/listing/presentation/bloc/image_listing_bloc.dart';
import 'package:image_listing_app/features/listing/presentation/pages/image_listing_page.dart';
import 'package:image_listing_app/features/listing/presentation/widgets/image_grid_builder.dart';
import 'package:image_listing_app/presentation/widgets/loading/app_loading_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listing_page_test.mocks.dart'; // Mock class for ImageListingCubit

@GenerateMocks([ImageListingCubit])
void main() {
  final locator = GetIt.instance;
  const urlSet = ['url'];
  tearDown(() {
    locator.reset();
  });

  testWidgets('displays loader when state is Initial', (WidgetTester tester) async {
    //Local set up for each tests
    final mockCubit = MockImageListingCubit();
    when(mockCubit.state).thenReturn(const ImageListingState());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.getImageList()).thenAnswer((_) async => urlSet);

    locator.registerFactory<ImageListingCubit>(() => mockCubit);
    // Arrange
    when(mockCubit.state).thenReturn(const ImageListingState());

    // Act
    await tester.pumpWidget(
      BlocProvider.value(
          value: mockCubit,
          child: const MaterialApp(
            home: ListingPage(),
          )),
    );

    // Assert
    expect(find.byType(AppLoader), findsOneWidget);
  });

  testWidgets('should show ImageGridBuilder with correct data', (tester) async {
    final mockCubit = MockImageListingCubit();
    when(mockCubit.state).thenReturn(
      const ImageListingState.imageLoaded(urlSet, true),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.getImageList()).thenAnswer((_) async => urlSet);
    locator.registerFactory<ImageListingCubit>(() => mockCubit);
    // Arrange

    await tester.pumpWidget(
      BlocProvider.value(
          value: mockCubit,
          child: const MaterialApp(
            home: ListingPage(),
          )),
    );

    // Act & Assert
    await tester.pumpAndSettle();
    expect(find.byType(ImageGridBuilder), findsOneWidget);
    expect(find.byType(AppLoader), findsNothing);
  });
}
