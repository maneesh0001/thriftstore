import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(CartItemEntity item) async {
    await repository.removeFromCart(item);
  }
}
