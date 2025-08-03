// import 'package:dartz/dartz.dart';
// import 'package:thrift_store/core/error/failure.dart' show Failure;
// import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';

 
// abstract interface class IAuthRepository {
//   Future<Either<Failure, void>> createAccount(UserEntity user);
//   Future<Either<Failure, String>> loginToAccount(String email, String password);
// }


import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/auth_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';


abstract interface class IAuthRepository {
  Future<Either<Failure, void>> createAccount(UserEntity user);
Future<Either<Failure, LoginResponse>> loginToAccount(String email, String password);
  Future<Either<Failure, AuthEntity>> getCurrentUser();
    Future<Either<Failure, String>> uploadProfilePicture(File file);
    Future<Either<Failure, void>> updateUser(String name, String email,int age, String phone);
}