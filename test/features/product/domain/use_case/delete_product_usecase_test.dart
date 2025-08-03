import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/domain/repository/product_repository.dart';
import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart';
import 'package:thrift_store/features/product/domain/use_case/delete_product_usecase.dart';

// 1️⃣ Mocks
class MockProductRepository extends Mock implements IProductRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late DeleteProductUseCase deleteProductUseCase;
  late MockProductRepository mockProductRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    deleteProductUseCase = DeleteProductUseCase(
      productRepository: mockProductRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  group('DeleteProductUseCase', () {
    const tProductId = 'product_123';
    const tToken = 'sample_token';
    const tParams = DeleteProductParams(productId: tProductId, id: 'irrelevant');

    test('should return void when token is retrieved and deletion is successful', () async {
      // Arrange
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockProductRepository.deleteProduct(tProductId, tToken))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await deleteProductUseCase(tParams);

      // Assert
      expect(result, const Right(null));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockProductRepository.deleteProduct(tProductId, tToken)).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return Failure when token retrieval fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Token not found');
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await deleteProductUseCase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNever(() => mockProductRepository.deleteProduct(any(), any()));
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return Failure when deletion fails after token retrieval', () async {
      // Arrange
      final failure = ApiFailure(message: 'Deletion failed');
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      when(() => mockProductRepository.deleteProduct(tProductId, tToken))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await deleteProductUseCase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockProductRepository.deleteProduct(tProductId, tToken)).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
