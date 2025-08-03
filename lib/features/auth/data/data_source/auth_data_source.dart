// File: lib/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/auth_entity.dart'; // Add this import
import 'dart:io'; // Add this import for File

abstract interface class IAuthDataSource {
  Future<void> createAccount(UserEntity user);
  Future<LoginResponse> loginToAccount(String email, String password);

  //  ADD THESE MISSING METHODS TO THE INTERFACE ---
  Future<AuthEntity> getCurrentUser();
  Future<String> uploadProfilePicture(File file);
  Future<void> updateUser(String name, String email, int age, String phone);
  
}

