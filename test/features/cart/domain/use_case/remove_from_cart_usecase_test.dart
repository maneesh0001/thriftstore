import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';
import 'package:thrift_store/features/cart/domain/use_case/remove_from_cart_usecase.dart';

// 1️⃣ Mock the repository
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late RemoveFromCartUseCase removeFromCartUseCase;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    removeFromCartUseCase = RemoveFromCartUseCase(mockCartRepository);
  });

  // Needed because mocktail requires a fallback value for custom types when using any()
  setUpAll(() {
    registerFallbackValue(
      CartItemEntity(productId: 'fallback', quantity: 1),
    );
  });

  group('RemoveFromCartUseCase', () {
    final tCartItem = CartItemEntity(
      productId: 'product_123',
      quantity: 1,
    );

    test('should call repository.removeFromCart with correct CartItemEntity', () async {
      // Arrange
      when(() => mockCartRepository.removeFromCart(any()))
          .thenAnswer((_) async {});

      // Act
      await removeFromCartUseCase(tCartItem);

      // Assert
      verify(() => mockCartRepository.removeFromCart(tCartItem)).called(1);
      verifyNoMoreInteractions(mockCartRepository);
    });
  });
}
