
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:thrift_store/core/error/failure.dart';
// import 'package:thrift_store/core/usecase/usecase.dart';
// import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';

// class AddProductParams extends Equatable {
//   final String productId;
//   final String userId;
//   final String productName;

//   final double productPrice;
//   final int productQuantity;

//   const AddProductParams(
//       {required this.productId,
//       required this.userId,
//       required this.productName,
//       required this.productPrice,
//       required this.productQuantity});

//   @override
//   List<Object?> get props => [productId, userId, productQuantity];
// }

// class AddProductUsecase implements UsecaseWithParams<void, AddProductParams> {
//   final CartRepository _repository;

//   AddProductUsecase({required CartRepository repository})
//       : _repository = repository;

//   @override
//   Future<Either<Failure, void>> call(AddProductParams params) async {
//     final result = await _repository.addProductToCart(
//       CartItemEntity(
//         productId: params.productId,
//         productName: params.productName,
//         productImage: '',
//         productDescription: '',
//         quantity: params.productQuantity,
//         price: params.productPrice,
//       ),
      
//     );

//     return result;
//   }
// }