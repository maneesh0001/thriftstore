import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';
import 'package:thrift_store/features/cart/domain/use_case/add_to_cart_usecase.dart';

// 1️⃣ Create a mock repository
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late AddToCartUseCase addToCartUseCase;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    addToCartUseCase = AddToCartUseCase(mockCartRepository);
  });

  setUpAll(() {
    registerFallbackValue(
      CartItemEntity(productId: '1', quantity: 1),
    );
  });

  group('AddToCartUseCase', () {
    final tCartItem = CartItemEntity(
      productId: 'product_123',
      quantity: 2,
    );

    test('should call repository.addToCart with correct CartItemEntity', () async {
      // Arrange
      when(() => mockCartRepository.addToCart(any()))
          .thenAnswer((_) async {});

      // Act
      await addToCartUseCase(tCartItem);

      // Assert
      verify(() => mockCartRepository.addToCart(tCartItem)).called(1);
      verifyNoMoreInteractions(mockCartRepository);
    });
  });
}
