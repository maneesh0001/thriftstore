import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

// No need for json_serializable annotations for this manual approach
class CartItemModel {
  final String productId;
  final int quantity;
  final String? productName;
  final String? productImage;
  final String? productDescription;
  final double? price;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.productName,
    this.productImage,
    this.productDescription,
    this.price,
  });

  // A single, simple factory to parse the JSON correctly.
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // Safely access the nested 'product' object.
    final productMap = json['product'] as Map<String, dynamic>?;

    return CartItemModel(
      // Get the product ID from WITHIN the nested 'product' map.
      // If productMap or _id is null, default to an empty string.
      productId: productMap?['_id'] as String? ?? '',

      // Get the quantity from the top level.
      quantity: json['quantity'] as int? ?? 0,

      // Get other details from the nested 'product' map.
      productName: productMap?['name'] as String?,
      productImage: productMap?['imageUrl'] as String?,
      productDescription: productMap?['description'] as String?,
      price: (productMap?['price'] as num?)?.toDouble(),
    );
  }

  // Convert the model back to an entity for your BLoC/UI.
  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      quantity: quantity,
      productName: productName,
      productImage: productImage,
      productDescription: productDescription,
      price: price,
    );
  }
}
