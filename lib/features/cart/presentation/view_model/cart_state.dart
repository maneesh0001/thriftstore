import 'package:equatable/equatable.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

class CartState extends Equatable {
  final List<CartItemEntity> items;
  final bool isLoading;
  final String? error;

  // New user info fields
  final String? email;
  final String? name;
  final String? role;

  const CartState({
    required this.items,
    required this.isLoading,
    this.error,
    this.email,
    this.name,
    this.role,
  });

  factory CartState.initial() {
    return const CartState(
      items: [],
      isLoading: false,
      error: null,
      email: null,
      name: null,
      role: null,
    );
  }

  CartState copyWith({
    List<CartItemEntity>? items,
    bool? isLoading,
    String? error,
    String? email,
    String? name,
    String? role,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error, email, name, role];
}
