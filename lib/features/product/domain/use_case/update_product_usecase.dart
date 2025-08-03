import 'package:dartz/dartz.dart';

import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import '../../../../core/error/failure.dart';

import '../repository/product_repository.dart';

class UpdateProductParams {
  final String id;
  final String title;
  final String description;
  final String photo;
  final double price;
  final String productId;
  final ProductEntity product;

  UpdateProductParams({
    required this.id,
    required this.title,
    required this.description,
    required this.photo,
    required this.price,
    required this.productId,
    required this.product,
  });
}

class UpdateProductUseCase {
  final IProductRepository productRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateProductUseCase({
    required this.productRepository,
    required this.tokenSharedPrefs,
  });

  Future<Either<Failure, void>> call(UpdateProductParams params) async {
    final tokenResult = await tokenSharedPrefs.getToken();

    // Debugging print
    print("Token result: $tokenResult");

    return tokenResult.fold(
      (failure) => Left(failure),
      (token) async {
        print("Calling repository.updateProduct with: ${params.product}");
        return productRepository.updateProduct(params.product, token);
      },
    );
  }
}
