import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/core/usecase/usecase.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

import '../../../../core/error/failure.dart';

import '../repository/product_repository.dart';

// class GetProductByIdParams extends Equatable {
//   final String productId;

//   const GetProductByIdParams({required this.productId, required String id});

//   @override
//   List<Object?> get props => [productId];
// }

// class GetProductByIdUseCase
//     implements UsecaseWithParams<ProductEntity, GetProductByIdParams> {
//   final IProductRepository productRepository;

//   GetProductByIdUseCase({required this.productRepository});

//   @override
//   Future<Either<Failure, ProductEntity>> call(
//       GetProductByIdParams params) async {
//     return productRepository.getProductById(params.productId);
//   }
// }

class GetProductByIdParams extends Equatable {
  final String id;
  final String productId;

  const GetProductByIdParams({required this.id, required this.productId});

  @override
  List<Object?> get props => [id, productId];
}

class GetProductByIdUseCase
    implements UsecaseWithParams<ProductEntity, GetProductByIdParams> {
  final IProductRepository productRepository;

  GetProductByIdUseCase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(
      GetProductByIdParams params) async {
    return productRepository.getProductById(params.productId);
  }
}
