// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:thrift_store/core/usecase/usecase.dart';
// import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

// import '../../../../core/error/failure.dart';

// import '../repository/product_repository.dart';

// class CreateProductParams extends Equatable {
//   final String title;
//   final double price;
//   final String productId;
//   final String? description;
//   final double? discountPrice;
//   final String? photo;

//   const CreateProductParams({
//     required this.title,
//     required this.price,
//     required this.productId,
//     this.description,
//     this.discountPrice,
//     this.photo,
//   });

//   @override
//   List<Object?> get props => [
//         title,
//         price,
//         productId,
//         description,
//         discountPrice,
//         photo,
//       ];

//   static empty() {}
// }

// class CreateProductUseCase
//     implements UsecaseWithParams<void, CreateProductParams> {
//   final IProductRepository productRepository;

//   CreateProductUseCase({required this.productRepository});

//   @override
//   Future<Either<Failure, void>> call(CreateProductParams params) async {
//     return await productRepository.createProduct(
//       ProductEntity(
//         title: params.title,
//         price: params.price,
//         productId: params.productId,
//         description: params.description,
//         discountPrice: params.discountPrice,
//         photo: params.photo, name: '', stock: null, category: '', longDescription: '', additionalInfo: '', imageUrl: '',
//       ),
//     );
//   }
// }
