// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      productId: json['_id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      stock: (json['stock'] as num).toInt(),
      category: json['category'] as String,
      condition: json['condition'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
      'category': instance.category,
      'condition': instance.condition,
      'imageUrl': instance.imageUrl,
    };
