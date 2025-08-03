import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

import '../../../../../core/network/hive_service.dart';
import '../../model/product_hive_model.dart';
import '../product_data_source.dart';


class ProductLocalDataSource implements IProductDataSource {
  final HiveService _hiveService;

  ProductLocalDataSource(this._hiveService);

  @override
  Future<void> createProduct(ProductEntity productEntity) async {
    try {
      final productHiveModel = ProductHiveModel.fromEntity(productEntity);
      await _hiveService.addProduct(productHiveModel); // Keep this in mind for the next fix
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  @override
  Future<void> deleteProduct(String productId, String? token) async {
    try {
      await _hiveService.deleteProduct(productId);
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  @override
  // Changed from getAllProduct to getAllProducts
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final products = await _hiveService.getAllProducts();
      return products.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching all products: $e');
    }
  }

  @override
  Future<ProductEntity> getProductById(String productId) async {
    try {
      final productHiveModel = await _hiveService.getProductById(productId);
      if (productHiveModel != null) {
        return productHiveModel.toEntity();
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      throw Exception('Error fetching product by ID: $e');
    }
  }

  @override
  Future<void> updateProduct(ProductEntity productEntity) async {
    try {
      final productHiveModel = ProductHiveModel.fromEntity(productEntity);
      await _hiveService.updateProduct(productHiveModel);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }
}