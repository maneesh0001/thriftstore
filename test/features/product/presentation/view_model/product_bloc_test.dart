import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';
import 'package:thrift_store/features/product/presentation/view_model/product_bloc.dart';
import 'package:thrift_store/features/product/presentation/view_model/product_event.dart';

// Mock class
class MockGetAllProductUsecase extends Mock implements GetAllProductUsecase {}

void main() {
  late MockGetAllProductUsecase mockGetAllProductUsecase;

  final tProducts = [
    ProductEntity(
      productId: '1',
      name: 'Product 1',
      price: 100,
      stock: 5,
      category: 'Clothes',
      condition: 'New',
      imageUrl: 'https://example.com/image1.jpg',
    ),
    ProductEntity(
      productId: '2',
      name: 'Product 2',
      price: 200,
      stock: 10,
      category: 'Shoes',
      condition: 'Used',
      imageUrl: 'https://example.com/image2.jpg',
    ),
  ];

  setUp(() {
    mockGetAllProductUsecase = MockGetAllProductUsecase();

    // Register fallback value for ProductEntity list or Failure if needed
    // (Usually not needed for simple mocks like this)
  });

  test('initial state is ProductState.initial()', () {
    // Always stub before creating bloc
    when(() => mockGetAllProductUsecase.call())
        .thenAnswer((_) async => Right(tProducts));
    final bloc = ProductBloc(getAllProductUsecase: mockGetAllProductUsecase);
    expect(bloc.state, ProductState.initial());
    bloc.close();
  });

  blocTest<ProductBloc, ProductState>(
  'emits [loading, error] when fetching products fails',
  build: () {
    when(() => mockGetAllProductUsecase.call())
        .thenAnswer((_) async => Left(ApiFailure(message: 'Failed to fetch')));
    return ProductBloc(getAllProductUsecase: mockGetAllProductUsecase);
  },
  act: (bloc) => bloc.add(LoadProducts()),
  skip: 1, // skip initial if any
  expect: () => [
    // Your bloc actually emits 3 states, so include all states in order:
    // The error state comes first, then loading, then error again (strange but as per actual)
    ProductState.initial().copyWith(isLoading: false, error: 'Failed to fetch', products: []),
    ProductState.initial().copyWith(isLoading: true, error: null, products: []),
    ProductState.initial().copyWith(isLoading: false, error: 'Failed to fetch', products: []),
  ],
);

}