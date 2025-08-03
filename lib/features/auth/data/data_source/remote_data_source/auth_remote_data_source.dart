

// File: lib/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart

import 'package:dio/dio.dart';
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
import 'package:thrift_store/core/network/api_service.dart';
import 'package:thrift_store/features/auth/data/data_source/auth_data_source.dart';
import 'package:thrift_store/features/auth/data/model/auth_api_model.dart';
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/auth_entity.dart';
import 'dart:io';

class AuthRemoteDataSource implements IAuthDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<void> createAccount(UserEntity user) async {
    try {
      // --- FIX: Use the renamed factory constructor from AuthApiModel ---
      final authApiModel =
          AuthApiModel.fromUserEntity(user); // <--- CHANGE HERE
      // --- END FIX ---
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: authApiModel.toJson(),
      );
      if ((response.statusCode ?? 500) ~/ 100 == 2) {
        return;
      } else {
        throw Exception('User registration failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      print("DIO ERROR TYPE: ${error.type}");
      print("DIO ERROR MESSAGE: ${error.message}");
      print("DIO ERROR RESPONSE: ${error.response?.data}");
      throw Exception('Login failed: ${error.message}');
    } catch (error) {
      throw Exception('User registration failed: $error');
    }
  }

  @override
Future<LoginResponse> loginToAccount(
  String email,
  String password,
) async {
  try {
    final response = await _apiService.dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data == null) {
        throw Exception('Login failed: Empty response data');
      }

      // Parse the full login response (token + user)
      final loginResponse = LoginResponse.fromJson(data);
      return loginResponse;
    } else {
      throw Exception('Login failed: ${response.statusMessage}');
    }
  } on DioException catch (error) {
    print("DIO ERROR TYPE: ${error.type}");
    print("DIO ERROR MESSAGE: ${error.message}");
    print("DIO ERROR RESPONSE: ${error.response?.data}");
    throw Exception('Login failed: ${error.message}');
  } catch (error) {
    throw Exception('Login failed: $error');
  }
}


  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      final response = await _apiService.dio.get(
        ApiEndpoints.currentUser,
      );

      if (response.statusCode == 200) {
        final authApiModel = AuthApiModel.fromJson(response.data);
        // --- FIX: Use the renamed toAuthEntity() method ---
        return authApiModel.toAuthEntity(); // <--- CHANGE HERE
        // --- END FIX ---
      } else {
        throw Exception(
            'Failed to get current user: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Failed to get current user: ${error.message}');
    } catch (error) {
      throw Exception('Failed to get current user: $error');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _apiService.dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        final imageUrl = response.data['imageUrl'];
        if (imageUrl == null) {
          throw Exception('Upload failed: Image URL not found in response');
        }
        return imageUrl;
      } else {
        throw Exception(
            'Failed to upload profile picture: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Failed to upload profile picture: ${error.message}');
    } catch (error) {
      throw Exception('Failed to upload profile picture: $error');
    }
  }

  @override
  Future<void> updateUser(
      String name, String email, int age, String phone) async {
    try {
      final response = await _apiService.dio.put(
        ApiEndpoints.updateUser,
        data: {
          'name': name,
          'email': email,
          'age': age,
          'phone': phone,
        },
      );

      if ((response.statusCode ?? 500) ~/ 100 == 2) {
        return;
      } else {
        throw Exception('Failed to update user: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Failed to update user: ${error.message}');
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }
}
