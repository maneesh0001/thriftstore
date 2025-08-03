// File: lib/features/product/data/data_source/product_data_source.dart

import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

abstract interface class IProductDataSource {
  // These methods *must* be declared here
  Future<void> createProduct(ProductEntity productEntity);
  Future<void> deleteProduct(String productId, String? token);
  Future<List<ProductEntity>> getAllProducts(); // <--- Ensure this is here and named exactly 'getAllProducts'
  Future<ProductEntity> getProductById(String productId);
  Future<void> updateProduct(ProductEntity productEntity);
}