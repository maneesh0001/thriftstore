import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/app/use_case/use_case.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';

class AuthRegisterParams extends Equatable {
  final String email;
  final String name;
  final String password;
  final String? role;

  const AuthRegisterParams({
    required this.email,
    required this.name,
    required this.password,
    this.role,
  });

  const AuthRegisterParams.initial({
    required this.email,
    required this.name,
    required this.password,
    this.role,
  });

  @override
  List<Object?> get props => [email, name, password, role];
}

class AuthRegisterUsecase
    implements UseCaseWithParams<void, AuthRegisterParams> {
  final IAuthRepository _authRepository;

  AuthRegisterUsecase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(AuthRegisterParams params) {
    final userEntity = UserEntity(
      email: params.email,
      name: params.name,
      password: params.password,
      role: params.role ?? 'user',
    );

    return _authRepository.createAccount(userEntity);
  }
}
