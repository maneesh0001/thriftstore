// File: lib/features/auth/data/repository/auth_remote_repository.dart
import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';
import 'package:thrift_store/features/auth/domain/entity/auth_entity.dart'; // Import AuthEntity
import 'dart:io'; // Import File for uploadProfilePicture

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, void>> createAccount(UserEntity user) async {
    try {
      await _authRemoteDataSource.createAccount(user);
      return Right(unit);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> loginToAccount(
    String email,
    String password,
  ) async {
    try {
      final loginResponse =
          await _authRemoteDataSource.loginToAccount(email, password);
      return Right(loginResponse);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }

  // --- START OF MISSING IMPLEMENTATIONS ---

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      // You'll need a method in your AuthRemoteDataSource to get the current user
      // For example:
      final authEntity = await _authRemoteDataSource.getCurrentUser();
      return Right(authEntity);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      // You'll need a method in your AuthRemoteDataSource to upload a profile picture
      // For example:
      final imageUrl = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageUrl);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(
      String name, String email, int age, String phone) async {
    try {
      // You'll need a method in your AuthRemoteDataSource to update user details
      // For example:
      await _authRemoteDataSource.updateUser(name, email, age, phone);
      return Right(unit);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
  // --- END OF MISSING IMPLEMENTATIONS ---
}
