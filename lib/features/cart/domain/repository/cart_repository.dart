import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(CartItemEntity item);
  Future<void> clearCart();
  Future<List<CartItemEntity>> fetchCartItems( String userId);
}
