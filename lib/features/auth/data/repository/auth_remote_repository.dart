import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, void>> createAccount(UserEntity user) async {
    try {
      await _authRemoteDataSource.createAccount(user);
      return Right(null);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginToAccount(
      String email,
      String password,
  ) async {
    try {
      final token = await _authRemoteDataSource.loginToAccount(email, password);
      return Right(token);
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
}
