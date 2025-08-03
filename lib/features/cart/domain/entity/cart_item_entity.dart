import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final int quantity;

  // Optional fields can be used if you're populating data for UI display
  final String? productName;
  final String? productImage;
  final String? productDescription;
  final double? price;

  const CartItemEntity({
    required this.productId,
    required this.quantity,
    this.productName,
    this.productImage,
    this.productDescription,
    this.price,
  });

  @override
  List<Object?> get props => [
        productId,
        quantity,
        productName,
        productImage,
        productDescription,
        price,
      ];
}
