import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

import 'package:thrift_store/features/product/domain/repository/product_repository.dart';
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';

// Mock repository
class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late GetAllProductUsecase getAllProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProductUsecase = GetAllProductUsecase(productRepository: mockProductRepository);
  });

  group('GetAllProductUsecase', () {
    final tProducts = [
      ProductEntity(
      
        name: 'Product 1',
      
        price: 100,
        stock: 10,
        category: '',
        condition: '',
        imageUrl: '', 
      ),
      ProductEntity(
        
        name: 'Product 2',
       
        price: 200,
        stock: 10,
        category: '',
        condition: '',
        imageUrl: '', 
      ),
    ];

    test('should return product list when repository call is successful', () async {
      // Arrange
      when(() => mockProductRepository.getProducts())
          .thenAnswer((_) async => Right<Failure, List<ProductEntity>>(tProducts));

      // Act
      final result = await getAllProductUsecase();

      // Assert
      expect(result.isRight(), true);
      expect(result.getOrElse(() => []), tProducts);
      verify(() => mockProductRepository.getProducts()).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return Failure when repository call fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Unable to fetch products');
      when(() => mockProductRepository.getProducts())
          .thenAnswer((_) async => Left<Failure, List<ProductEntity>>(failure));

      // Act
      final result = await getAllProductUsecase();

      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), failure);
      verify(() => mockProductRepository.getProducts()).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return empty list when repository returns empty', () async {
  // Arrange
  when(() => mockProductRepository.getProducts())
      .thenAnswer((_) async => Right<Failure, List<ProductEntity>>(<ProductEntity>[]));

  // Act
  final result = await getAllProductUsecase();

  // Assert
  expect(result.isRight(), true);
  expect(result.getOrElse(() => <ProductEntity>[]), <ProductEntity>[]);
  verify(() => mockProductRepository.getProducts()).called(1);
  verifyNoMoreInteractions(mockProductRepository);
});

  });
}
