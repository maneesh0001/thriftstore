import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart' show Failure;
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';

 
abstract interface class IAuthRepository {
  Future<Either<Failure, void>> createAccount(UserEntity user);
  Future<Either<Failure, String>> loginToAccount(String email, String password);
}