import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

import '../../model/product_api_model.dart';

class ProductRemoteDataSource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  ProductRemoteDataSource(this._dio, this._userSharedPrefs);

  Future<void> createProduct(ProductEntity product) async {
    try {
      // Convert entity to model
      var productApiModel = ProductApiModel.fromEntity(product);
      var response = await _dio.post(
        ApiEndpoints.createProduct,
        data: productApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final tokenResult = await _userSharedPrefs.getUserData();
      String token = '';
      tokenResult.fold(
        (failure) => throw Exception('Token fetch failed: ${failure.message}'),
        (userData) => token = userData.token,
      );

      debugPrint("🔐 Using token: $token");

      final response = await _dio.get(
        ApiEndpoints.getAllProducts,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      debugPrint("📦 Response: ${response.statusCode}, ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data.map((e) => ProductApiModel.fromJson(e).toEntity()).toList();
      } else {
        throw Exception(
            "Error ${response.statusCode}: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      debugPrint("❌ DioException: ${e.message}");
      debugPrint("❌ DioException Type: ${e.type}");
      debugPrint("❌ DioException Response: ${e.response?.data}");
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      debugPrint("❌ Unexpected Error: $e");
      throw Exception("Unexpected error: $e");
    }
  }

  Future<ProductEntity> getProductById(String productId) async {
    try {
      var response =
          await _dio.get('${ApiEndpoints.getProductById}/$productId');
      if (response.statusCode == 200) {
        return ProductApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateProduct(ProductEntity productEntity, param) async {
    try {
      var productApiModel = ProductApiModel.fromEntity(productEntity);
      var response = await _dio.put(
        '${ApiEndpoints.updateProduct}/${productEntity.productId}',
        data: productApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteProduct(String productId, String? token) async {
    try {
      var response =
          await _dio.delete('${ApiEndpoints.deleteProduct}/$productId');
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
