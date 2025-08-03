import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/repository/product_repository.dart';
import 'package:thrift_store/features/product/domain/use_case/get_product_by_id_usecase.dart';

// 1️⃣ Mock repository
class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late GetProductByIdUseCase getProductByIdUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductByIdUseCase = GetProductByIdUseCase(productRepository: mockProductRepository);
  });

  group('GetProductByIdUseCase', () {
    const tProductId = 'product_123';
    const tParams = GetProductByIdParams(id: 'any_id', productId: tProductId);

    final tProduct = ProductEntity(
    
      name: 'Test Product',
      
      price: 150, stock: 1, category: '', condition: '', imageUrl: '',
    );

    test('should return ProductEntity when repository call is successful', () async {
      // Arrange
      when(() => mockProductRepository.getProductById(tProductId))
          .thenAnswer((_) async => Right(tProduct));

      // Act
      final result = await getProductByIdUseCase(tParams);

      // Assert
      expect(result, Right(tProduct));
      verify(() => mockProductRepository.getProductById(tProductId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return Failure when repository call fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Product not found');
      when(() => mockProductRepository.getProductById(tProductId))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await getProductByIdUseCase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockProductRepository.getProductById(tProductId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
