import 'package:equatable/equatable.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String userId;
  final List<CartItemEntity> items;
  final double totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final DateTime? bookedAt;

  const BookingEntity({
    this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.bookedAt,
  });

  @override
  List<Object?> get props =>
      [id, userId, items, totalPrice, createdAt, updatedAt, status, bookedAt];
}