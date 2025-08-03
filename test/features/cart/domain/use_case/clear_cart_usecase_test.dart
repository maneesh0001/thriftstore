import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';
import 'package:thrift_store/features/cart/domain/use_case/clear_cart_usecase.dart';

// 1️⃣ Create a mock repository
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late ClearCartUseCase clearCartUseCase;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    clearCartUseCase = ClearCartUseCase(mockCartRepository);
  });

  group('ClearCartUseCase', () {
    test('should call repository.clearCart once', () async {
      // Arrange
      when(() => mockCartRepository.clearCart()).thenAnswer((_) async {});

      // Act
      await clearCartUseCase();

      // Assert
      verify(() => mockCartRepository.clearCart()).called(1);
      verifyNoMoreInteractions(mockCartRepository);
    });
  });
}
