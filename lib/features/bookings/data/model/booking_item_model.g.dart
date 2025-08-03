// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingItemModel _$BookingItemModelFromJson(Map<String, dynamic> json) =>
    BookingItemModel(
      productId: json['product'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$BookingItemModelToJson(BookingItemModel instance) =>
    <String, dynamic>{
      'product': instance.productId,
      'quantity': instance.quantity,
    };
