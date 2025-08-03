// lib/features/cart/data/data_source/cart_datasource.dart

import 'package:dio/dio.dart';
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';
import 'package:thrift_store/core/network/api_service.dart';
import 'package:thrift_store/features/cart/data/model/cart_item_api_model.dart';
import 'package:thrift_store/features/cart/data/model/cart_item_model.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

class CartDatasource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  CartDatasource(
      {required ApiService apiService,
      required UserSharedPrefs userSharedPrefs})
      : _dio = apiService.dio,
        _userSharedPrefs = userSharedPrefs;

  Future<String> sharedPrefUserId() async {
    final userDataResult = await _userSharedPrefs.getUserData();
    return userDataResult.fold(
      (failure) {
        throw Exception('Failed to get user ID: ${failure.message}');
      },
      (userData) => userData.userId,
    );
  }

  Future<void> addProductToCart(
    CartItemEntity product,
  ) async {
    try {
      final userId = await sharedPrefUserId();
      final response = await _dio.post(ApiEndpoints.addProductToCart, data: {
        "userId": userId,
        "productId": product.productId,
        "quantity": product.quantity
      });
      if (response.statusCode == 200) {
        print("Product added to cart successfully");
        return;
      } else {
        print("Failed to add product to cart: ${response.statusCode}");
        throw Exception(response.statusMessage ?? "Unknown error occurred");
      }
    } on DioException catch (e) {
      print("DioError in addProductToCart: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Error type: ${e.type}");
      throw Exception(e.message ?? "An unknown Dio error occurred.");
    } catch (e) {
      print("Generic error in addProductToCart: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> removeProductFromCart(
    CartItemEntity product,
  ) async {
    try {
      final userId = await sharedPrefUserId();
      final response =
          await _dio.post(ApiEndpoints.removeProductFromCart, data: {
        "userId": userId,
        "productId": product.productId,
      });
      if (response.statusCode == 200) {
        print("Product removed from cart successfully");
        return;
      } else {
        print("Failed to remove product from cart: ${response.statusCode}");
        throw Exception(response.statusMessage ?? "Unknown error occurred.");
      }
    } on DioException catch (e) {
      print("DioError in removeProductFromCart: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Error type: ${e.type}");
      throw Exception(e.message ?? "An unknown Dio error occurred.");
    } catch (e) {
      print("Generic error in removeProductFromCart: $e");
      throw Exception(e.toString());
    }
  }
// lib/features/cart/data/data_source/cart_datasource.dart

  Future<void> clearCart() async {
    try {
      // ✨ FIX: Change to .delete() and remove the unnecessary 'data' body
      final response = await _dio.delete(ApiEndpoints.clearCart);

      if (response.statusCode == 200) {
        print("Cart cleared successfully");
        return;
      } else {
        print("Failed to clear cart: ${response.statusCode}");
        throw Exception(response.statusMessage ?? "Unknown error occurred.");
      }
    } on DioException catch (e) {
      print("DioError in clearCart: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Error type: ${e.type}");
      throw Exception(e.message ?? "An unknown Dio error occurred.");
    } catch (e) {
      print("Generic error in clearCart: $e");
      throw Exception(e.toString());
    }
  }

  Future<List<CartItemEntity>> getCartProducts() async {
    try {
      final response = await _dio.get(ApiEndpoints.cart);

      if (response.statusCode == 200) {
        print("Cart items fetched successfully");

        // FIX: Handle cases where backend sends null for no cart or empty cart
        // If response.data is null, it means no cart was found, so return an empty list.
        if (response.data == null) {
          print("Backend returned null for cart data. Treating as empty cart.");
          return [];
        }

        // Ensure response.data is a Map. If not, it's an unexpected format.
        if (!(response.data is Map)) {
          print(
              "Invalid response format for getCartProducts: Expected a Map but got ${response.data.runtimeType}.");
          throw Exception(
              "Invalid response format: Expected a Map for cart data.");
        }

        final Map<String, dynamic> cartData =
            response.data as Map<String, dynamic>;

        // Ensure 'items' key exists and its value is a List. If not, treat as empty cart.
        // A cart can exist but have no items, so cartData['items'] might be an empty list or missing.
        if (!cartData.containsKey('items') || !(cartData['items'] is List)) {
          print(
              "Cart data does not contain 'items' key or 'items' is not a List. Treating as empty cart.");
          return [];
        }

        final List<dynamic> cartItemsJson = cartData['items'];

        // Map JSON items to CartItemEntity.
        // The CartItemModel.fromJson should now correctly handle 'product' as String or Map,
        // as per our previous fixes.
        final List<CartItemEntity> cartItems = cartItemsJson
            .map((e) =>
                CartItemModel.fromJson(e as Map<String, dynamic>).toEntity())
            .toList();

        return cartItems;
      } else {
        print("Failed to fetch cart items: ${response.statusCode}");
        throw Exception(response.statusMessage ?? "Unknown error occurred.");
      }
    } on DioException catch (e) {
      print("DioError in getCartProducts: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Error type: ${e.type}");
      throw Exception(e.message ?? "An unknown Dio error occurred.");
    } catch (e) {
      print("Generic error in getCartProducts: $e");
      throw Exception(e.toString());
    }
  }
}
