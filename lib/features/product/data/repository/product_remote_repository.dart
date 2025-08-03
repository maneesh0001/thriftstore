import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/product/data/data_source/remote_datasource/product_remote_data_source.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/repository/product_repository.dart';

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching products: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) async {
    try {
      await remoteDataSource.createProduct(product);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error creating product: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String productId) async {
    try {
      final product = await remoteDataSource.getProductById(productId);
      return Right(product);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching product by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product, dynamic param) async {
    try {
      await remoteDataSource.updateProduct(product, param);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error updating product: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId, String? token) async {
    try {
      await remoteDataSource.deleteProduct(productId, token);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error deleting product: $e'));
    }
  }
}
