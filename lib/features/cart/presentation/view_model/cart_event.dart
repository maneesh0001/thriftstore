part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {
  const LoadCartEvent();
}

class AddProductToCartEvent extends CartEvent {
  final String productId;
  final String productName;
  final double productPrice;
  final int productQuantity;

  const AddProductToCartEvent({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  List<Object?> get props => [productId, productName, productPrice, productQuantity];
}

class RemoveProductFromCartEvent extends CartEvent {
  final String productId;

  const RemoveProductFromCartEvent({
    required this.productId,
  });

  @override
  List<Object?> get props => [productId];
}

class ClearCartEvent extends CartEvent {}

// lib/features/cart/presentation/view_model/cart_event.dart

class IncrementItemQuantityEvent extends CartEvent {
  final String productId;
  const IncrementItemQuantityEvent(this.productId);
  @override List<Object> get props => [productId];
}

class DecrementItemQuantityEvent extends CartEvent {
  final String productId;
  const DecrementItemQuantityEvent(this.productId);
  @override List<Object> get props => [productId];
}
