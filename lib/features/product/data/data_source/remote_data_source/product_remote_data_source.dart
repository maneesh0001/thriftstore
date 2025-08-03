
// import 'package:dio/dio.dart';
// import 'package:thrift_store/app/constant/api/api_endpoints.dart';
// import 'package:thrift_store/features/product/data/data_source/product_data_source.dart';
// import 'package:thrift_store/features/product/data/model/product_api_model.dart';
// import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

// class ProductRemoteDataSource implements IProductDataSource {
//   final Dio _dio;

//   ProductRemoteDataSource({
//     required Dio dio,
//   }) : _dio = dio;

//    @override
//   Future<List<ProductEntity>> getProducts() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.getAllProducts);
//       if (response.statusCode == 200) {
//         // Assuming the API returns a JSON array of products
//         final List products = response.data;
//         return products
//             .map((json) => ProductApiModel.fromJson(json).toEntity())
//             .toList();
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
