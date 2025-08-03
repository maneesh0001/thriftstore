import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

class ProductDetailView extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Image.network(
              '${ApiEndpoints.imageUrl}${product.imageUrl?.replaceFirst("/uploads/", "")}',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                ),
              ),
            ),
            // Product Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product Price
                  Text(
                    'Rs. ${product.price}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product Details (Category & Condition)
                  Row(
                    children: [
                      _buildInfoChip(Icons.category, product.category),
                      const SizedBox(width: 10),
                      _buildInfoChip(Icons.healing, product.condition),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.condition ?? 'No Condition specified',
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey[700], height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Add to Cart Button at the bottom
      bottomNavigationBar: _buildAddToCartButton(context),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.teal[700]),
      label: Text(label),
      backgroundColor: Colors.teal.withOpacity(0.1),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Add to Cart'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          context.read<CartBloc>().add(
                AddProductToCartEvent(
                  productId: product.productId.toString(),
                  productName: product.name,
                  productPrice: product.price.toDouble(),
                  productQuantity: 1,
                ),
              );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} added to cart!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
