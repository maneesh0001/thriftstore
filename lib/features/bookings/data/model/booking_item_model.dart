// lib/features/bookings/data/model/booking_item_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

part 'booking_item_model.g.dart';

@JsonSerializable()
class BookingItemModel {
  // This model expects 'product' to be a simple String ID.
  @JsonKey(name: 'product')
  final String productId;

  final int quantity;

  BookingItemModel({
    required this.productId,
    required this.quantity,
  });

  factory BookingItemModel.fromJson(Map<String, dynamic> json) =>
      _$BookingItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingItemModelToJson(this);

  // We can still convert this simpler model to the same CartItemEntity
  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      quantity: quantity,
      // Other fields will be null since the booking API doesn't provide them.
    );
  }
}