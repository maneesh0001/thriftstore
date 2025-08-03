import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/app/use_case/use_case.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';//unit test

 
class LoginParams extends Equatable {
  final String email;
  final String password;
 
  const LoginParams({required this.email, required this.password});
 
  const LoginParams.initial() : email = '', password = '';
  @override
  List<Object?> get props => [email, password];
}
 // Use LoginResponse type instead of String
class AuthLoginUsecase implements UseCaseWithParams<LoginResponse, LoginParams> {
  final IAuthRepository _authRepository;

  AuthLoginUsecase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await _authRepository.loginToAccount(
      params.email,
      params.password,
    );
  }
}
