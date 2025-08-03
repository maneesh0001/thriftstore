
import 'package:dartz/dartz.dart';

import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/core/usecase/usecase.dart';

import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/repository/product_repository.dart';

class GetAllProductUsecase implements UsecaseWithoutParams<List<ProductEntity>> {
  final IProductRepository productRepository;

  GetAllProductUsecase({required this.productRepository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call() {
    return productRepository.getProducts();
  }
}
