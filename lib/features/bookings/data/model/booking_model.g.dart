// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['_id'] as String?,
      userId: json['user'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => BookingItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String?,
      bookedAt: json['bookedAt'] == null
          ? null
          : DateTime.parse(json['bookedAt'] as String),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.userId,
      'items': instance.items,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'bookedAt': instance.bookedAt?.toIso8601String(),
    };
