import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/core/usecase/usecase.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';

import '../../../../core/error/failure.dart';
import '../repository/product_repository.dart';

class DeleteProductParams extends Equatable {
  final String productId;

  const DeleteProductParams({required this.productId, required String id});

  @override
  List<Object?> get props => [productId];
}

class DeleteProductUseCase
    implements UsecaseWithParams<void, DeleteProductParams> {
  final IProductRepository productRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteProductUseCase(
      {required this.productRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) async {
    // Get token from Shared Preferences and send it to server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await productRepository.deleteProduct(params.productId, r);
    });
  }
}
