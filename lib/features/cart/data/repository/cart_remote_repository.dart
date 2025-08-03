import 'package:thrift_store/features/cart/data/data_source/cart_datasource.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource _cartDatasource;

  CartRepositoryImpl({required CartDatasource cartDatasource})
      : _cartDatasource = cartDatasource;

  @override
Future<void> addToCart(CartItemEntity item) {
  return _cartDatasource.addProductToCart(item);
}

  @override
  Future<void> removeFromCart(CartItemEntity item) {
    return _cartDatasource.removeProductFromCart(item);
  }

  @override
  Future<void> clearCart() {
    return _cartDatasource.clearCart();
  }

  @override
  Future<List<CartItemEntity>> fetchCartItems( String userId) {
    return _cartDatasource.getCartProducts();
  }
}
