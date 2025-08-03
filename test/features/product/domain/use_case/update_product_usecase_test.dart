import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/repository/product_repository.dart';
import 'package:thrift_store/features/product/domain/use_case/update_product_usecase.dart';

// 1️⃣ Mock classes
class MockProductRepository extends Mock implements IProductRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late UpdateProductUseCase updateProductUseCase;
  late MockProductRepository mockProductRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    updateProductUseCase = UpdateProductUseCase(
      productRepository: mockProductRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  // Register fallback for ProductEntity used in any()
  setUpAll(() {
    registerFallbackValue(ProductEntity(
      
      name: 'fallback',
      
      price: 0, stock: 1, category: '', condition: '', imageUrl: '',
    ));
  });

  group('UpdateProductUseCase', () {
    final tProduct = ProductEntity(
     
      name: 'Product 1',
     
      price: 50, stock: 1, category: '', condition: '', imageUrl: '',
    );

    final tParams = UpdateProductParams(
      id: 'user_1',
      title: 'Product 1',
      description: 'Description 1',
      photo: 'photo_url',
      price: 50,
      productId: 'prod_1',
      product: tProduct,
    );

    const tToken = 'valid_token';

    test('should return void when token is retrieved and update succeeds', () async {
      // Arrange
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockProductRepository.updateProduct(tProduct, tToken))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await updateProductUseCase(tParams);

      // Assert
      expect(result, const Right(null));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockProductRepository.updateProduct(tProduct, tToken)).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return Failure when token retrieval fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Token not found');
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await updateProductUseCase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNever(() => mockProductRepository.updateProduct(any(), any()));
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return Failure when update fails after token retrieval', () async {
      // Arrange
      final failure = ApiFailure(message: 'Update failed');
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockProductRepository.updateProduct(tProduct, tToken))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await updateProductUseCase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockProductRepository.updateProduct(tProduct, tToken)).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
