import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';

// 1️⃣ Mock the repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late AuthRegisterUsecase authRegisterUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authRegisterUsecase = AuthRegisterUsecase(authRepository: mockAuthRepository);
  });

  // 2️⃣ Register fallback values for mocktail
  setUpAll(() {
    registerFallbackValue(UserEntity(
      email: '',
      name: '',
      password: '',
      role: 'user',
    ));
  });

  group('AuthRegisterUsecase', () {
    const tEmail = 'test@example.com';
    const tName = 'Test User';
    const tPassword = 'password123';
    const tRole = 'user';

    const tParams = AuthRegisterParams(
      email: tEmail,
      name: tName,
      password: tPassword,
      role: tRole,
    );

    final tUserEntity = UserEntity(
      email: tEmail,
      name: tName,
      password: tPassword,
      role: tRole,
    );

    test('should return void when registration is successful', () async {
      // Arrange
      when(() => mockAuthRepository.createAccount(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await authRegisterUsecase(tParams);

      // Assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.createAccount(tUserEntity)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when registration fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Email already exists');
      when(() => mockAuthRepository.createAccount(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await authRegisterUsecase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.createAccount(tUserEntity)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
