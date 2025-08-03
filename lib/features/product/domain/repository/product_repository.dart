import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

abstract interface class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, void>> createProduct(ProductEntity product);
  Future<Either<Failure, void>> updateProduct(ProductEntity product, dynamic param);
  Future<Either<Failure, void>> deleteProduct(String productId, String? token);
  Future<Either<Failure, ProductEntity>> getProductById(String productId);
}
