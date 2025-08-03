// lib/features/bookings/data/model/booking_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:thrift_store/features/bookings/data/model/booking_item_model.dart'; // ✨ CHANGE 1: Import the new model
import 'package:thrift_store/features/bookings/domain/entity/booking_entity.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final String userId;

  final List<BookingItemModel> items; // ✨ CHANGE 2: Use the new model here

  final double totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final DateTime? bookedAt;

  const BookingModel({
    this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.bookedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      userId: userId,
      items: items.map((item) => item.toEntity()).toList(),
      totalPrice: totalPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      bookedAt: bookedAt,
    );
  }
}